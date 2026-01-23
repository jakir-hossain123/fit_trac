import 'package:fit_trac/presentation/screens/walk_summery/walk_summery_grid.dart';
import 'package:fit_trac/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../walk_tracking/widgets/walk_map_view.dart';
import 'package:fit_trac/services/tracking_service.dart' as trk;
import 'package:fit_trac/services/history_service.dart';

// Helper class for Summary Data
class SummaryStatData {
  final String value;
  final String label;
  final String change;
  final String svgPath;
  final Color color;

  SummaryStatData({
    required this.value,
    required this.label,
    required this.change,
    required this.svgPath,
    required this.color,
  });
}

class WalkSummaryScreen extends StatefulWidget {
  const WalkSummaryScreen({super.key});

  @override
  State<WalkSummaryScreen> createState() => _WalkSummaryScreenState();
}

class _WalkSummaryScreenState extends State<WalkSummaryScreen> {
  static const double calorieFactor = 60.0;
  bool _isSaved = false; // Flag to ensure data is saved only once

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes min $seconds sec';
  }

  // Method to persist session data to local storage
  void _saveToHistory(Map<String, dynamic> data, int calories) {
    if (!_isSaved) {
      // Type must match the filter used in HistoryScreen
      HistoryService.saveSession("Walking", {
        'distance': data['distance'] ?? 0.0,
        'steps': data['steps'] ?? 0,
        'time': data['time'] ?? 0,
        'kcal': calories.toDouble(),
      });
      _isSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF0F1418);

    return FutureBuilder<Map<String, dynamic>>(
      future: trk.getFinalTrackingData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: darkBackground,
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        final data = snapshot.data ?? {};
        final double totalDistanceKm = data['distance'] ?? 0.0;
        final int totalSeconds = data['time'] ?? 0;
        final int steps = data['steps'] ?? 0;
        final List<LatLng> routePoints = List<LatLng>.from(data['routePoints'] ?? []);

        final int calories = (totalDistanceKm * calorieFactor).toInt();

        // Save data after the widget is rendered to avoid build-phase side effects
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _saveToHistory(data, calories);
        });

        final List<SummaryStatData> summaryStats = [
          SummaryStatData(
            value: '${totalDistanceKm.toStringAsFixed(2)} km',
            label: 'Distance',
            change: '+0%',
            svgPath: 'assets/icons/distance.svg',
            color: Colors.blueAccent,
          ),
          SummaryStatData(
            value: _formatTime(totalSeconds),
            label: 'Time',
            change: '+0%',
            svgPath: 'assets/icons/time.svg',
            color: Colors.amber,
          ),
          SummaryStatData(
            value: calories.toString(),
            label: 'Calories',
            change: '+0%',
            svgPath: 'assets/icons/calories.svg',
            color: Colors.redAccent,
          ),
          SummaryStatData(
            value: steps.toString(),
            label: 'Steps',
            change: '+0%',
            svgPath: 'assets/icons/vector.svg',
            color: Colors.lightBlue,
          ),
        ];

        return Scaffold(
          backgroundColor: darkBackground,
          appBar: AppBar(
            backgroundColor: darkBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
              },
            ),
            title: const Text(
              "Walk Summary",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Render the map with the recorded GPS points
                WalkMapView(initialRoutePoints: routePoints),
                const SizedBox(height: 30),
                // Display statistics in a grid layout
                WalkSummaryGrid(stats: summaryStats),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text(
                      "Back to Home",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}