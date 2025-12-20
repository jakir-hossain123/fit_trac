import 'package:flutter/material.dart';
import '../../running/runnign_summary/running_summery_grid.dart';

class PushUpSummary extends StatelessWidget {
  const PushUpSummary({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF0F1418);

    final List<SummaryStatData> pushUpStats = [
      SummaryStatData(value: '3/3', label: 'Sets', change: '+ 8%', svgPath: 'assets/icons/sets.svg', color: Colors.blueAccent),
      SummaryStatData(value: '12', label: 'Reps', change: '+ 6%', svgPath: 'assets/icons/reps.svg', color: Colors.lightBlue),
      SummaryStatData(value: '16 min', label: 'Time', change: '- 8%', svgPath: 'assets/icons/time.svg', color: Colors.amber),
      SummaryStatData(value: '209', label: 'Calories', change: '+ 8%', svgPath: 'assets/icons/calories.svg', color: Colors.redAccent),
    ];

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF12191D),
        elevation: 0,
        title: const Text("Push-up Summary", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal.withOpacity(0.3), width: 4),
                ),
                child: const Icon(Icons.check, color: Colors.tealAccent, size: 50),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Push Ups Complete!",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Great Job! You've pushed through. Keep that momentum going.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
            const SizedBox(height: 40),

            RunningSummeryGrid(stats: pushUpStats),

            const Spacer(),

            const Text("Up Next", style: TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 5),
            const Text("Squats", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1E3A3A)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("Repeat", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF135D5A),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("Next", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}