import 'package:flutter/material.dart';
import '../../../services/history_service.dart';
import 'day_details.dart';

class ActivityDetailScreen extends StatelessWidget {
  final String activityType;
  const ActivityDetailScreen({super.key, required this.activityType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF20262B),
        title: Text("$activityType History", style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: HistoryService.getLastSevenDaysSummary(activityType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No history available", style: TextStyle(color: Colors.white54)),
            );
          }

          final weekData = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: weekData.length,
            itemBuilder: (context, index) {
              final day = weekData[index];
              final bool hasData = day['hasData'];
              final DateTime date = day['date'];

              return Card(
                color: hasData ? const Color(0xFF1A2127) : const Color(0xFF1A2127).withOpacity(0.5),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: hasData ? Colors.teal.withOpacity(0.5) : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  onTap: hasData
                      ? () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DayDetailScreen(dayData: day)),
                  )
                      : null,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${date.day}/${date.month}",
                        style: const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.white24, size: 18),
                    ],
                  ),
                  title: Text(
                    day['label'], // Today, Yesterday, or Day Name
                    style: TextStyle(
                      color: hasData ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    hasData ? "Activity recorded" : "No activity",
                    style: TextStyle(color: hasData ? Colors.tealAccent : Colors.white24),
                  ),
                  trailing: hasData
                      ? const Icon(Icons.arrow_forward_ios, color: Colors.teal, size: 16)
                      : const Icon(Icons.block, color: Colors.white10, size: 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}