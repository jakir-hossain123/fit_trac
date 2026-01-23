import 'package:fit_trac/presentation/screens/running/runnign_summary/running_summery_grid.dart';
import 'package:fit_trac/services/tracking_service.dart' as trk;
import 'package:fit_trac/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../routes.dart';
import '../running_progress/widgets/run_map_vies.dart';

class RunningSummary extends StatefulWidget {
  const RunningSummary({super.key});

  @override
  State<RunningSummary> createState() => _RunningSummaryState();
}

class _RunningSummaryState extends State<RunningSummary> {
  static const double calorieFactor = 70.0;
  bool _isSaved = false;

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }


  void _saveToHistory(Map<String, dynamic> data, double calories) {
    if (!_isSaved) {
      HistoryService.saveSession("Running", {
        'distance': data['distance'] ?? 0.0,
        'steps': data['steps'] ?? 0,
        'time': data['time'] ?? 0,
        'kcal': calories,
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
        final double distanceKm = data['distance'] ?? 0.0;
        final int timeSeconds = data['time'] ?? 0;
        final int totalSteps = data['steps'] ?? 0;
        final List<LatLng> finalRoute = List<LatLng>.from(data['routePoints'] ?? []);
        final double totalCalories = distanceKm * calorieFactor;

       
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _saveToHistory(data, totalCalories);
        });

        final String formattedTime = _formatTime(timeSeconds);

        final List<SummaryStatData> dynamicRunSummaryStats = [
          SummaryStatData(
            value: '${distanceKm.toStringAsFixed(2)} km',
            label: 'Distance',
            change: '+6%',
            svgPath: 'assets/icons/distance.svg',
            color: Colors.blueAccent,
          ),
          SummaryStatData(
            value: totalSteps.toString(),
            label: 'Steps',
            change: '+6%',
            svgPath: 'assets/icons/vector.svg',
            color: Colors.lightBlue,
          ),
          SummaryStatData(
            value: formattedTime,
            label: 'Time',
            change: '-8%',
            svgPath: 'assets/icons/time.svg',
            color: Colors.amber,
          ),
          SummaryStatData(
            value: '${totalCalories.toStringAsFixed(0)} kcal',
            label: 'Calories',
            change: '+6%',
            svgPath: 'assets/icons/calories.svg',
            color: Colors.redAccent,
          ),
        ];

        return Scaffold(
          backgroundColor: darkBackground,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
              },
            ),
            backgroundColor: darkBackground,
            elevation: 0,
            title: const Text(
              "Run Summary",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RunMapView(initialRoutePoints: finalRoute),
                const SizedBox(height: 30),
                RunningSummeryGrid(stats: dynamicRunSummaryStats),
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