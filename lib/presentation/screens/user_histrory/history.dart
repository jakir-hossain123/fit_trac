import 'package:flutter/material.dart';
import '../../../routes.dart';
import '../../../utils/app_theme.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF20262B),
        title: const Text("Activity History", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal,
                width: 1.0,
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
              },              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTotalUsageCard("2h 15m", "Total Active Today"),
            const SizedBox(height: 20),

            _buildActivityCard(Icons.play_circle_fill, "Watching Videos", "45 mins", Colors.redAccent),
            _buildActivityCard(Icons.directions_walk, "Walking Time", "30 mins", Colors.blueAccent),
            _buildActivityCard(Icons.directions_run, "Running Time", "15 mins", Colors.orangeAccent),
            _buildActivityCard(Icons.fitness_center, "Freehand Exercise", "40 mins", AppTheme.primaryTeal),
            _buildActivityCard(Icons.smartphone, "App Exploration", "5 mins", Colors.purpleAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalUsageCard(String time, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.inputFieldColor,
        borderRadius: BorderRadius.circular(20),
      ),
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

  Widget _buildActivityCard(IconData icon, String title, String duration, Color color) {
    return Card(
      color: AppTheme.inputFieldColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        trailing: Text(duration, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
      ),
    );
  }
}