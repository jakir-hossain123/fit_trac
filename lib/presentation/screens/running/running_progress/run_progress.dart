import 'dart:async';
import 'package:fit_trac/presentation/screens/running/running_progress/widgets/run_controll_buttons.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/widgets/run_map_vies.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/widgets/run_progress_bar.dart';
import 'package:fit_trac/presentation/screens/running/running_progress/widgets/start_run_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fit_trac/services/tracking_service.dart';
import '../../../../../routes.dart';

// Constants
const double _caloriesPerKm = 70.0;
const int _defaultInstantRunGoalSeconds = 10 * 60;
const Color _darkBackground = Color(0xFF0F1418);

class RunProgress extends StatefulWidget {
  const RunProgress({super.key});

  @override
  State<RunProgress> createState() => _RunProgressState();
}

class _RunProgressState extends State<RunProgress> {
  // Map View Key
  final GlobalKey<RunMapViewState> _mapViewKey = GlobalKey<RunMapViewState>();

  // Tracking State Variables
  double _totalDistanceKm = 0.0;
  int _totalSteps = 0;
  int _timeElapsedSeconds = 0;
  double _caloriesBurned = 0.0;
  bool _isRunning = false;
  bool _isPaused = false;
  List<LatLng> _routePoints = [];

  // Background Service Communication
  final service = FlutterBackgroundService();
  StreamSubscription? _serviceStreamSubscription;
  StreamSubscription? _stopEventSubscription;

  @override
  void initState() {
    super.initState();
    _listenToServiceUpdates();
    _listenForStopConfirmation();
  }


  // Navigates to the summary page after the background service confirms data is saved.
  void _listenForStopConfirmation() {
    _stopEventSubscription = service.on('tracking_stopped_and_saved').listen((data) async {
      if (data != null && data['readyToNavigate'] == true) {

        // 🛑 পরিবর্তন: SharedPreferences থেকে ডেটা লোড করার প্রয়োজন নেই।
        // সামারি পেজ নিজেই getFinalTrackingData() ব্যবহার করে লোড করবে।
        // final finalData = await getFinalTrackingData(); // REMOVED

        // Navigate to summary page (Push Replacement ensures the user cannot return to the running screen easily)
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.runningSummary,
            // 🛑 পরিবর্তন: arguments বাদ দেওয়া হলো।
            // arguments: { ... } // REMOVED
          );
        }
      }
    });
  }

  void _listenToServiceUpdates() {
    _serviceStreamSubscription = service.on('update').listen((data) {
      if (data != null) {
        setState(() {
          _totalDistanceKm = (data['distance'] as num?)?.toDouble() ?? 0.0;
          _timeElapsedSeconds = data['time'] ?? 0;
          _totalSteps = data['steps'] ?? 0;

          _isRunning = data['isRunning'] ?? false;
          _isPaused = data['isPaused'] ?? false;
          _caloriesBurned = _totalDistanceKm * _caloriesPerKm;

          // Map view update
          final List<List<dynamic>> rawPoints = List<List<dynamic>>.from(data['routePoints'] ?? []);
          _routePoints = rawPoints.map((p) => LatLng(p[0] as double, p[1] as double)).toList();
          _mapViewKey.currentState?.updateRoute(_routePoints);
        });
      }
    });
  }

  // Control Functions

  Future<void> _handleStart() async {
    // 1. Always attempt to start the service
    try {
      service.startService();
    } catch (e) {
      // Handle error starting service if necessary
    }

    // Send command to service to start tracking
    service.invoke(COMMAND_START_TRACKING);
  }

  void _handlePause() {
    if (_isRunning && !_isPaused) {
      service.invoke(COMMAND_PAUSE);
    }
  }

  void _handleResume() {
    if (_isRunning && _isPaused) {
      service.invoke(COMMAND_RESUME);
    }
  }

  // Stop command
  void _handleStop() {
    service.invoke(COMMAND_STOP);
  }


  // Utility Functions

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _serviceStreamSubscription?.cancel();
    _stopEventSubscription?.cancel(); // Cancel the new subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Instant Run
    double goalProgressValue = 0.0;
    String runTypeLabel = "Instant Run";

    if (_defaultInstantRunGoalSeconds > 0) {
      goalProgressValue = _timeElapsedSeconds / _defaultInstantRunGoalSeconds;
    }
    if (goalProgressValue > 1.0) goalProgressValue = 1.0;


    final List<StatData> dynamicRunStats = [
      StatData(
        value: '${_totalDistanceKm.toStringAsFixed(2)} km',
        label: 'Distance',
        svgPath: 'assets/icons/distance.svg',
        color: Colors.blueAccent,
      ),
      StatData(
        value: _totalSteps.toString(),
        label: 'Steps',
        svgPath: 'assets/icons/vector.svg',
        color: Colors.lightBlue,
      ),
      StatData(
        value: _formatTime(_timeElapsedSeconds),
        label: 'Time',
        svgPath: 'assets/icons/time.svg',
        color: Colors.amber,
      ),
      StatData(
        value: '${_caloriesBurned.toStringAsFixed(0)} kcal',
        label: 'Calories',
        svgPath: 'assets/icons/calories.svg',
        color: Colors.redAccent,
      ),
    ];

    return Scaffold(
      backgroundColor: _darkBackground,
      appBar: AppBar(
        backgroundColor: _darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            _handlePause();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Running!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map View
            RunMapView(
              key: _mapViewKey,
            ),
            const SizedBox(height: 16),

            // Progress Bar
            RunProgressBar(
              isRunning: _isRunning,
              isPaused: _isPaused,
              timeElapsed: _timeElapsedSeconds,
              distance: _totalDistanceKm,
              progressValue: goalProgressValue,
              runType: runTypeLabel,
            ),
            const SizedBox(height: 20),

            // Stats Grid
            StartRunGrid(stats: dynamicRunStats),
            const SizedBox(height: 30),

            // Control Buttons
            RunControlButtons(
              isRunning: _isRunning,
              isPaused: _isPaused,
              onStart: (_isPaused) ? _handleResume : _handleStart,
              onPause: _handlePause,
              onResume: _handleResume,
              onStop: _handleStop,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}