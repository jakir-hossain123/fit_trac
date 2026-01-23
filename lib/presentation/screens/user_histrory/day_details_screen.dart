import 'package:flutter/material.dart';

class DayDetailScreen extends StatelessWidget {
  final Map<String, dynamic> dayData;
  const DayDetailScreen({super.key, required this.dayData});

  @override
  Widget build(BuildContext context) {
    // ডাটা যদি নাল থাকে তবে একটি খালি ম্যাপ নিবে
    final data = dayData['data'] ?? {};
    final bool hasData = dayData['hasData'] ?? false;
    final String label = dayData['label'] ?? "Activity";

    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF20262B),
        title: Text("$label Summary", style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: !hasData || data.isEmpty
          ? const Center(
          child: Text("No data recorded for this day",
              style: TextStyle(color: Colors.white54)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Performance Overview",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard(
                    "Distance",
                    "${(data['distance'] ?? 0.0).toStringAsFixed(2)} km",
                    Icons.route,
                    Colors.blueAccent
                ),
                _buildStatCard(
                    "Steps",
                    "${data['steps'] ?? 0}",
                    Icons.directions_walk,
                    Colors.lightBlue
                ),
                _buildStatCard(
                    "Duration",
                    _formatMinutes(data['time'] ?? data['watchTimeSeconds'] ?? data['duration_seconds'] ?? 0),
                    Icons.timer,
                    Colors.amber
                ),
                _buildStatCard(
                    "Calories",
                    "${(data['kcal'] ?? 0).toStringAsFixed(0)} kcal",
                    Icons.local_fire_department,
                    Colors.redAccent
                ),
              ],
            ),

            const SizedBox(height: 30),
            _buildAchievementSection(),
          ],
        ),
      ),
    );
  }

  // এখানে dynamic টাইপ ব্যবহার করা হয়েছে যাতে int বা double দুইটাই হ্যান্ডেল করা যায়
  String _formatMinutes(dynamic seconds) {
    if (seconds == null) return "0 mins";
    int sec = 0;
    if (seconds is String) {
      sec = int.tryParse(seconds) ?? 0;
    } else {
      sec = (seconds as num).toInt();
    }
    int mins = sec ~/ 60;
    return "$mins mins";
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2127),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          FittedBox( // বড় টেক্সট হলে যেন ভেঙ্গে না যায়
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAchievementSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.teal.withOpacity(0.2), Colors.transparent]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Great Job!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("You maintained your streak for this day.", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}