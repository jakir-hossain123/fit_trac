
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fit_trac/routes.dart';

import '../walk/model/tracking_goal.dart';
import 'widgets/walk_control_buttons.dart';
import 'widgets/walk_map_view.dart';
import 'widgets/walk_progress_bar.dart';
import 'widgets/walk_start_grid.dart';


// tracking state Enum
enum TrackingState { initial, running, paused }


class WalkProgressScreen extends StatefulWidget {
  const WalkProgressScreen({super.key});

  @override
  State<WalkProgressScreen> createState() => _WalkProgressScreenState();
}


class _WalkProgressScreenState extends State<WalkProgressScreen> {
  final GlobalKey<WalkMapViewState> _mapViewKey = GlobalKey<WalkMapViewState>();


  TrackingGoal? _trackingGoal;
  TrackingState _currentState = TrackingState.initial;
  double _currentDistanceKm = 0.0;
  int _elapsedSeconds = 0;
  Timer? _timer;


  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;

      });
    });
  }

  void _startTracking() {
    if (_currentState == TrackingState.initial || _currentState == TrackingState.paused) {
      setState(() {
        _currentState = TrackingState.running;
      });
      _startTimer();
      _mapViewKey.currentState?.startLocationTracking();
    }
  }

  void _pauseTracking() {
    if (_currentState == TrackingState.running) {
      setState(() {
        _currentState = TrackingState.paused;
      });
      _timer?.cancel();
      _mapViewKey.currentState?.pauseLocationTracking();
    }
  }

  void _stopTracking() {
    _timer?.cancel();
    _mapViewKey.currentState?.stopLocationTracking();

    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.walkSummery,
            (route) => false,
        arguments: {
          'distance': _currentDistanceKm,
          'time': _elapsedSeconds,
        }
    );
  }

  void _updateDistance(double newDistanceKm) {
    setState(() {
      _currentDistanceKm = newDistanceKm;
    });

  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_trackingGoal == null) {
      _trackingGoal = ModalRoute.of(context)?.settings.arguments as TrackingGoal?;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_trackingGoal == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F1418),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    const Color darkBackground = Color(0xFF0F1418);

    String title = "Walking!";
    if (_trackingGoal!.type == GoalType.time) {
      title = "${_trackingGoal!.targetValue} min Walk";
    } else if (_trackingGoal!.type == GoalType.distance) {
      double km = _trackingGoal!.targetValue / 1000;
      title = "${km.toStringAsFixed(1)} km Walk";
    }

    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');


    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
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
            WalkMapView(
              key: _mapViewKey,
              onDistanceUpdated: _updateDistance,
            ),
            const SizedBox(height: 16),

            WalkProgressBar(
              progressValue: _currentDistanceKm / 5.0,
              walkType: _trackingGoal!.type == GoalType.time ? 'Time Goal' : 'Distance Goal',
            ),
            const SizedBox(height: 20),

            WalkStatsGrid(
              distance: _currentDistanceKm,
              elapsedTime: '$minutes:$seconds', distanceKm: _currentDistanceKm,
            ),
            const SizedBox(height: 30),

            WalkControlButtons(
              currentState: _currentState,
              onStart: _startTracking,
              onPause: _pauseTracking,
              onStop: _stopTracking,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}