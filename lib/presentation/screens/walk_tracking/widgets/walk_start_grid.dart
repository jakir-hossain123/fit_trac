import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatData {
  final String value;
  final String label;
  final String svgPath;
  final Color color;

  StatData({
    required this.value,
    required this.label,
    required this.svgPath,
    required this.color,
  });
}


class WalkStatsGrid extends StatelessWidget {
  final double distanceKm;
  final String elapsedTime;

  const WalkStatsGrid({
    super.key,
    required this.distanceKm,
    required this.elapsedTime, required double distance,
  });

  @override
  Widget build(BuildContext context) {
    // Steps & Calories Calculation
    final int steps = (distanceKm * 1300).toInt();
    final int calories = (distanceKm * 60).toInt();

    // Dynamic Stat List
    final List<StatData> walkStats = [
      StatData(
        value: '${distanceKm.toStringAsFixed(2)} km',
        label: 'Distance',
        svgPath: 'assets/icons/distance.svg',
        color: Colors.blueAccent,
      ),
      StatData(
        value: steps.toString(),
        label: 'Steps',
        svgPath: 'assets/icons/vector.svg',
        color: Colors.lightBlue,
      ),
      StatData(
        value: elapsedTime,
        label: 'Time',
        svgPath: 'assets/icons/time.svg',
        color: Colors.amber,
      ),
      StatData(
        value: calories.toString(),
        label: 'Calories',
        svgPath: 'assets/icons/calories.svg',
        color: Colors.redAccent,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 80,
      ),
      itemCount: walkStats.length,
      itemBuilder: (context, index) {
        final stat = walkStats[index];
        return StatCard(
          value: stat.value,
          label: stat.label,
          svgPath: stat.svgPath,
          color: stat.color,
        );
      },
    );
  }
}


class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final String svgPath;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.svgPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF122027),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
