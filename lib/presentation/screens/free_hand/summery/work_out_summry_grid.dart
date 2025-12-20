import 'package:flutter/material.dart';

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

class RunningSummeryGrid extends StatelessWidget {
  final List<SummaryStatData> stats;
  const RunningSummeryGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 100,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => SummaryStatCard(stat: stats[index]),
    );
  }
}

class SummaryStatCard extends StatelessWidget {
  final SummaryStatData stat;
  const SummaryStatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2227),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stat.value,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flash_on, color: stat.color, size: 14),
              const SizedBox(width: 4),
              Text(stat.label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              const SizedBox(width: 6),
              Text(
                stat.change,
                style: TextStyle(
                  color: stat.change.contains('+') ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}