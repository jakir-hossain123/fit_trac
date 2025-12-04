import 'package:fit_trac/presentation/screens/walk_summery/walk_summery_grid.dart';
import 'package:fit_trac/routes.dart';
import 'package:fit_trac/services/tracking_service.dart'; // ✅ নতুন আমদানি
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../walk_tracking/widgets/walk_map_view.dart';

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


class WalkSummaryScreen extends StatelessWidget {
  const WalkSummaryScreen({super.key});

  static const double calorieFactor = 60.0;

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes min $seconds sec';
  }


  @override
  Widget build(BuildContext context) {
    // data from shared preferences

    return FutureBuilder<Map<String, dynamic>>(
      future: getFinalTrackingData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0F1418),
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        final data = snapshot.data ?? {};

        final double totalDistanceKm = data['distance'] ?? 0.0;
        final int totalSeconds = data['time'] ?? 0;
        final int steps = data['steps'] ?? 0;
        final List<LatLng> routePoints = List<LatLng>.from(data['routePoints'] ?? []);

        final String formattedTime = _formatTime(totalSeconds);
        final int calories = (totalDistanceKm * calorieFactor).toInt();


        // Summary Data Setup
        final List<SummaryStatData> summaryStats = [
          SummaryStatData(
            value: '${totalDistanceKm.toStringAsFixed(2)} km',
            label: 'Distance',
            change: '+0%',
            svgPath: 'assets/icons/distance.svg',
            color: Colors.blueAccent,
          ),
          SummaryStatData(
            value: formattedTime,
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

        const Color darkBackground = Color(0xFF0F1418);

        return Scaffold(
          backgroundColor: darkBackground,
          appBar: AppBar(
            backgroundColor: darkBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                // Navigate back to the home page after tracking
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
                // Display the recorded route on the map
                WalkMapView(
                  initialRoutePoints: routePoints,
                ),

                const SizedBox(height: 30),
                WalkSummaryGrid(stats: summaryStats),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}