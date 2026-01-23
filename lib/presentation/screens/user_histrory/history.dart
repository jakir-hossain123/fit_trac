import 'package:flutter/material.dart';
import '../../../routes.dart';
import '../../../utils/app_theme.dart';
import 'package:fit_trac/services/tracking_service.dart' as trk;

import 'activity_details_screen.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF20262B),
        title: const Text("Activity History",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        leading: _buildHomeButton(context),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: trk.getFinalTrackingData(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};

          // Get dynamic data from tracking service
          final String runTime = _formatDuration(data['time'] ?? 0);
          final String walkTime = "${data['steps'] ?? 0} steps";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTotalUsageCard("2h 15m", "Total Active Today"),
                const SizedBox(height: 20),

                _buildActivityCard(
                    context,
                    Icons.directions_run,
                    "Running Time",
                    runTime,
                    Colors.orangeAccent,
                    "Running"
                ),
                _buildActivityCard(
                    context,
                    Icons.directions_walk,
                    "Walking Time",
                    walkTime,
                    Colors.blueAccent,
                    "Walking"
                ),
                _buildActivityCard(context, Icons.fitness_center, "Freehand Exercise", "40 mins", AppTheme.primaryTeal, "Exercise"),
                _buildActivityCard(context, Icons.play_circle_fill, "Watching Videos", "45 mins", Colors.redAccent, "Video"),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(int seconds) {
    if (seconds == 0) return "0 mins";
    final minutes = seconds ~/ 60;
    return "$minutes mins";
  }

  Widget _buildActivityCard(BuildContext context, IconData icon, String title, String duration, Color color, String type) {
    return Card(
      color: AppTheme.inputFieldColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () {
          // Navigate to details page for last 7 days
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityDetailScreen(activityType: type),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(duration, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.teal)),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
          icon: const Icon(Icons.home_outlined, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildTotalUsageCard(String time, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppTheme.inputFieldColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
              Text(time, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
          const CircularProgressIndicator(value: 0.7, color: Colors.teal, strokeWidth: 8),
        ],
      ),
    );
  }
}