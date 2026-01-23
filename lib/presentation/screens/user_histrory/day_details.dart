
import 'package:flutter/material.dart';
class DayDetailScreen extends StatelessWidget {
  final Map<String, dynamic> dayData;
  const DayDetailScreen({super.key, required this.dayData});

  @override
  Widget build(BuildContext context) {
    var data = dayData['data'];
    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(title: Text(dayData['label'])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Activity for ${dayData['label']}", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            Text("Steps: ${data['steps'] ?? 0}", style: TextStyle(color: Colors.white, fontSize: 24)),
            Text("Time: ${(data['time'] / 60).toStringAsFixed(1)} mins", style: TextStyle(color: Colors.teal)),
          ],
        ),
      ),
    );
  }
}