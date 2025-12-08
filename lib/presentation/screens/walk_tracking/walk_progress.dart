import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fit_trac/routes.dart';
import 'package:fit_trac/services/tracking_service.dart';
import '../walk_time_selec/model/tracking_goal.dart';
import 'widgets/walk_control_buttons.dart';
import 'widgets/walk_map_view.dart';
import 'widgets/walk_progress_bar.dart';
import 'widgets/walk_start_grid.dart';

// Constants
const Color _darkBackground = Color(0xFF0F1418);

// Tracking state Enum
enum TrackingState { initial, running, paused }

class WalkProgressScreen extends StatefulWidget {
  const WalkProgressScreen({super.key});

  @override
  State<WalkProgressScreen> createState() => _WalkProgressScreenState();
}

class _WalkProgressScreenState extends State<WalkProgressScreen> {
  final GlobalKey<WalkMapViewState> _mapViewKey = GlobalKey<WalkMapViewState>();

  //  Tracking State Variables
  TrackingGoal? _trackingGoal;
  TrackingState _currentState = TrackingState.initial;
  double _currentDistanceKm = 0.0;
  int _elapsedSeconds = 0;
  int _currentSteps = 0;
  List<LatLng> _routePoints = [];
  bool _isPedometerAvailable = true;

  //  Background Service Communication
  final service = FlutterBackgroundService();
  StreamSubscription? _serviceStreamSubscription;
  StreamSubscription? _stopEventSubscription; // Added for safe stop handling

  @override
  void initState() {
    super.initState();
    _listenToServiceUpdates();
    _listenForStopConfirmation(); // Listen for service confirmation before navigating
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_trackingGoal == null) {
      _trackingGoal = ModalRoute.of(context)?.settings.arguments as TrackingGoal?;
      // If it's an instant walk, start automatically
      if (_trackingGoal?.type == GoalType.instant) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startTracking();
        });
      }
    }
  }

  // Listens for the explicit event from the background service
  // after it has saved data and is ready for UI navigation.
  void _listenForStopConfirmation() {
    // Assuming the background service sends an event like 'tracking_stopped_and_saved'
    _stopEventSubscription = service.on('tracking_stopped_and_saved').listen((data) async {
      if (data != null && data['readyToNavigate'] == true) {

        // 🛑 পরিবর্তন: এই লাইনটি আর প্রয়োজন নেই। WalkSummaryScreen নিজেই ডেটা লোড করবে।
        // final finalData = await getFinalTrackingData(); // REMOVED

        // Navigate to summary page
        if (mounted) {
          // ✅ পরিবর্তন: আর্গুমেন্ট ছাড়া নেভিগেট করুন।
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.walkSummery,
                (route) => false,
            // arguments: finalData // REMOVED
          );
        }
      }
    });
  }

  // function for share data from service
  void _listenToServiceUpdates() {
    _serviceStreamSubscription = service.on('update').listen((data) {
      if (data != null) {
        setState(() {
          _currentDistanceKm = (data['distance'] as num?)?.toDouble() ?? 0.0;
          _elapsedSeconds = data['time'] ?? 0;
          _currentSteps = data['steps'] ?? 0;

          final isRunning = data['isRunning'] ?? false;
          final isPaused = data['isPaused'] ?? false;
          _isPedometerAvailable = data['isPedometerAvailable'] ?? true;

          // State transition logic
          if (isRunning && !isPaused) {
            _currentState = TrackingState.running;
          } else if (isRunning && isPaused) {
            _currentState = TrackingState.paused;
          } else {
            // Note: This 'initial' state should typically only happen right before starting/after stopping.
            _currentState = TrackingState.initial;
          }

          // Map view update
          final List<List<dynamic>> rawPoints = List<List<dynamic>>.from(data['routePoints'] ?? []);
          _routePoints = rawPoints.map((p) => LatLng(p[0] as double, p[1] as double)).toList();
          _mapViewKey.currentState?.updateRoute(_routePoints);
        });

        // Check for goal completion
        _checkGoalCompletion();
      }
    });
  }


  //  Tracking Control Functions

  void _checkGoalCompletion() {
    if (_currentState == TrackingState.running && _trackingGoal != null) {
      // Time Goal Check: Target is in minutes, elapsed is in seconds
      if (_trackingGoal!.type == GoalType.time) {
        if (_elapsedSeconds >= _trackingGoal!.targetValue * 60) {
          _stopTracking(isGoalCompleted: true);
        }
      }
      // Distance Goal Check: Target is in meters, current distance is in km
      else if (_trackingGoal!.type == GoalType.distance) {
        // Convert km to meters for comparison: _currentDistanceKm * 1000
        if (_currentDistanceKm * 1000 >= _trackingGoal!.targetValue) {
          _stopTracking(isGoalCompleted: true);
        }
      }
    }
  }

  void _startTracking() async {

    // 1. Always attempt to start the service
    try {
      service.startService();
    } catch (e) {
      // Handle error if service fails to start
    }

    // 2. Send command to service to start tracking
    service.invoke(COMMAND_START_TRACKING);
  }

  void _pauseTracking() {
    if (_currentState == TrackingState.running) {
      service.invoke(COMMAND_PAUSE);
    }
  }

  void _resumeTracking() {
    if (_currentState == TrackingState.paused) {
      service.invoke(COMMAND_RESUME);
    }
  }

  void _stopTracking({bool isGoalCompleted = false}) {
    // Command the service to stop and save data
    service.invoke(COMMAND_STOP);


  }


  // Lifecycle Methods

  @override
  void dispose() {
    _serviceStreamSubscription?.cancel();
    _stopEventSubscription?.cancel(); // Cancel the new stop listener
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_trackingGoal == null) {
      return const Scaffold(
        backgroundColor: _darkBackground,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }


    String title = "Walking!";
    String walkTypeLabel = "Open Walk";
    double goalProgressValue = 0.0;


    if (_trackingGoal!.type == GoalType.time) {
      title = "${_trackingGoal!.targetValue} min Walk";
      walkTypeLabel = "Time Goal: ${_trackingGoal!.targetValue} min";
      final totalSecondsGoal = _trackingGoal!.targetValue * 60;
      goalProgressValue = (totalSecondsGoal > 0) ? _elapsedSeconds / totalSecondsGoal : 0.0;
    } else if (_trackingGoal!.type == GoalType.distance) {
      final double km = _trackingGoal!.targetValue / 1000;
      title = "${km.toStringAsFixed(1)} km Walk";
      walkTypeLabel = "Distance Goal: ${km.toStringAsFixed(1)} km";
      // Progress calculation: (Current distance in meters) / (Target distance in meters)
      goalProgressValue = (_trackingGoal!.targetValue > 0) ? (_currentDistanceKm * 1000) / _trackingGoal!.targetValue : 0.0;
    } else if (_trackingGoal!.type == GoalType.instant) {
      title = "Instant Walk";
      walkTypeLabel = "Instant Walk";
      const int instantGoalSeconds = 10 * 60;
      goalProgressValue = (instantGoalSeconds > 0) ? _elapsedSeconds / instantGoalSeconds : 0.0;
    }

    if (goalProgressValue > 1.0) goalProgressValue = 1.0;


    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');


    return Scaffold(
      backgroundColor: _darkBackground,
      appBar: AppBar(
        backgroundColor: _darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            _pauseTracking();
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map View
            WalkMapView(
              key: _mapViewKey,
              initialRoutePoints: _routePoints,
            ),
            const SizedBox(height: 16),

            WalkProgressBar(
              isRunning: _currentState == TrackingState.running || _currentState == TrackingState.paused,
              isPaused: _currentState == TrackingState.paused,
              timeElapsed: _elapsedSeconds,
              distance: _currentDistanceKm,
              progressValue: goalProgressValue,
              walkType: walkTypeLabel,
            ),
            const SizedBox(height: 20),

            // Walk Stats Grid
            WalkStatsGrid(
              distanceKm: _currentDistanceKm,
              elapsedTime: '$minutes:$seconds',
              steps: _currentSteps,
              isPedometerAvailable: _isPedometerAvailable,
            ),
            const SizedBox(height: 30),

            // Control Buttons
            WalkControlButtons(
              currentState: _currentState,
              // Correctly pass the Start or Resume handler based on current state
              onStart: (_currentState == TrackingState.paused) ? _resumeTracking : _startTracking,
              onPause: _pauseTracking,
              onStop: _stopTracking,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text('Test Crash'),
            )
          ],
        ),
      ),
    );
  }
}