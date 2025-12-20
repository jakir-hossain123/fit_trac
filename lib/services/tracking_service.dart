import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide NOTIFICATION_ID;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int NOTIFICATION_ID = 100;
const String NOTIFICATION_CHANNEL_ID = 'fit_trac_tracking';
const String NOTIFICATION_CHANNEL_NAME = 'Fitness Tracking Service';
const String NOTIFICATION_GROUP_KEY = 'basic_channel_group';

const String COMMAND_STOP = 'STOP_SERVICE';
const String COMMAND_PAUSE = 'PAUSE_TRACKING';
const String COMMAND_RESUME = 'RESUME_TRACKING';
const String COMMAND_START_TRACKING = 'START_TRACKING';

double _totalDistance = 0.0;
int _timeElapsedSeconds = 0;
int _totalSteps = 0;
List<LatLng> _routePoints = [];
Timer? _timer;
StreamSubscription<Position>? _positionSubscription;
StreamSubscription<StepCount>? _stepCountSubscription;
int? _initialSteps;
bool _isTrackingRunning = false;
bool _isTrackingPaused = false;
bool _isPedometerAvailable = true;

//    Service Initialization
Future<void> initializeService() async {
  WidgetsFlutterBinding.ensureInitialized();

  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false,
      notificationChannelId: NOTIFICATION_CHANNEL_ID,
      initialNotificationTitle: 'FitTrac Tracking',
      initialNotificationContent: 'Ready to track your fitness.',
      foregroundServiceNotificationId: NOTIFICATION_ID,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

// iOS background
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

//Service Start Handler
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // Foreground/Background status setup
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((_) => service.setAsForegroundService());
    service.on('setAsBackground').listen((_) => service.setAsBackgroundService());
  }

  service.on(COMMAND_STOP).listen((_) => _stopAllTracking(service));
  service.on(COMMAND_PAUSE).listen((_) => _pauseTracking(service));
  service.on(COMMAND_RESUME).listen((_) => _resumeTracking(service));
  service.on(COMMAND_START_TRACKING).listen((_) async => await _startNewTracking(service));

  // Initial data send when service starts
  _sendTrackingData(service);
}

// Core Tracking Logic

Future<void> _startLocationTracking(ServiceInstance service) async {
  // Check/Request Location Permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    return;
  }

  try {
    //  Get initial position and start stream
    Position initialPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _routePoints.clear();
    _routePoints.add(LatLng(initialPosition.latitude, initialPosition.longitude));
    await _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).listen((Position pos) => _updateTracking(pos, service),
    );

  } catch (e) {
  }
}

// pedometer permission check
void _startStepTracking(ServiceInstance service) {
  _stepCountSubscription?.cancel();
  _isPedometerAvailable = true;

  _stepCountSubscription = Pedometer.stepCountStream.listen(
        (StepCount event) {
      if (!_isTrackingPaused) {
        _initialSteps ??= event.steps;
        _totalSteps = event.steps - _initialSteps!;
        _sendTrackingData(service);
      }
    },
    onError: (e) {
      _isPedometerAvailable = false;
      _totalSteps = 0;
      _sendTrackingData(service);
    },
    cancelOnError: false,
  );
}


void _updateTracking(Position newPosition, ServiceInstance service) {
  if (_isTrackingPaused) return;

  LatLng newPoint = LatLng(newPosition.latitude, newPosition.longitude);
  if (_routePoints.isNotEmpty) {
    LatLng lastPoint = _routePoints.last;
    double distance = Geolocator.distanceBetween(
      lastPoint.latitude,
      lastPoint.longitude,
      newPoint.latitude,
      newPoint.longitude,
    );
    // 5 meters filter
    if (distance > 5) {
      _totalDistance += distance / 1000;
      _routePoints.add(newPoint);
    }
  } else {
    _routePoints.add(newPoint);
  }
  _sendTrackingData(service);
}


void _startTimer(ServiceInstance service) {
  _timer?.cancel();
  _timer = Timer.periodic(const Duration(seconds: 1), (_) {
    if (!_isTrackingPaused) {
      _timeElapsedSeconds++;
      _sendTrackingData(service);
    }
  });
}

// Control Functions

Future<void> _startNewTracking(ServiceInstance service) async {
  // If we receive the command while it's already running, just resume if paused
  if (_isTrackingRunning && _isTrackingPaused) {
    return _resumeTracking(service);
  }
  if (_isTrackingRunning) return;


  // Reset variables
  _totalDistance = 0.0;
  _timeElapsedSeconds = 0;
  _totalSteps = 0;
  _routePoints.clear();
  _initialSteps = null;
  _isTrackingRunning = true;
  _isTrackingPaused = false;

  // Start streams
  _startLocationTracking(service);
  _startStepTracking(service);
  _startTimer(service);
  _sendTrackingData(service);
}

void _pauseTracking(ServiceInstance service) {
  if (!_isTrackingRunning || _isTrackingPaused) return;
  _isTrackingPaused = true;
  _positionSubscription?.pause();
  _sendTrackingData(service);
}

void _resumeTracking(ServiceInstance service) {
  if (!_isTrackingRunning || !_isTrackingPaused) return;
  _isTrackingPaused = false;
  _positionSubscription?.resume();
  _sendTrackingData(service);
}

void _stopAllTracking(ServiceInstance service) {
  _isTrackingRunning = false;
  _isTrackingPaused = false;
  _timer?.cancel();
  _positionSubscription?.cancel();
  _stepCountSubscription?.cancel();
  AwesomeNotifications().cancel(NOTIFICATION_ID);

  // 1. SharedPreferences
  _saveFinalTrackingData();


  service.invoke('tracking_stopped_and_saved', {'readyToNavigate': true});


  service.stopSelf();
}

//5. Data Communication
void _sendTrackingData(ServiceInstance service) {
  final data = {
    'distance': _totalDistance,
    'time': _timeElapsedSeconds,
    'steps': _totalSteps,
    'routePoints': _routePoints.map((p) => [p.latitude, p.longitude]).toList(),
    'isRunning': _isTrackingRunning,
    'isPaused': _isTrackingPaused,
    'isPedometerAvailable': _isPedometerAvailable,
  };

  service.invoke('update', data);


  if (_timeElapsedSeconds == 0 || _timeElapsedSeconds % 3 == 0) {
    String dist = _totalDistance.toStringAsFixed(2);
    int mins = _timeElapsedSeconds ~/ 60;
    int secs = _timeElapsedSeconds % 60;
    String timeStr = '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    String title = _isTrackingPaused ? 'FitTrac: Paused' : 'FitTrac: Running $dist km';
    String content = 'Time: $timeStr | Steps: $_totalSteps';

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: NOTIFICATION_ID,
        channelKey: NOTIFICATION_CHANNEL_ID,
        title: title,
        body: content,
        notificationLayout: NotificationLayout.Default,
        locked: true,
        payload: {'data': 'tracking_session'},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'STOP_TRACKING',
          label: 'Stop Service',
          color: Colors.red,
          actionType: ActionType.KeepOnTop,
        ),
      ],
    );
  }
}

// SharedPreferences Data
void _saveFinalTrackingData() async {
  final prefs = await SharedPreferences.getInstance();
  final routeStrings = _routePoints.map((p) => '${p.latitude},${p.longitude}').toList();

  await prefs.setDouble('final_distance', _totalDistance);
  await prefs.setInt('final_time', _timeElapsedSeconds);
  await prefs.setInt('final_steps', _totalSteps);
  await prefs.setStringList('final_route', routeStrings);
}

Future<Map<String, dynamic>> getFinalTrackingData() async {
  final prefs = await SharedPreferences.getInstance();
  final distance = prefs.getDouble('final_distance') ?? 0.0;
  final time = prefs.getInt('final_time') ?? 0;
  final steps = prefs.getInt('final_steps') ?? 0;
  final routeStrings = prefs.getStringList('final_route') ?? [];

  final routePoints = routeStrings.map((str) {
    final parts = str.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }).toList();

  return {
    'distance': distance,
    'time': time,
    'steps': steps,
    'routePoints': routePoints,
  };
}