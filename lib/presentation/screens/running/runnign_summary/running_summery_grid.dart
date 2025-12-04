import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

//  RunningSummeryGrid
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
        mainAxisExtent: 110,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return SummaryStatCard(
          value: stat.value,
          label: stat.label,
          change: stat.change,
          svgPath: stat.svgPath,
          color: stat.color,
        );
      },
    );
  }
}

class SummaryStatCard extends StatelessWidget {
  final String value;
  final String label;
  final String change;
  final String svgPath;
  final Color color;

  const SummaryStatCard({
    super.key,
    required this.value,
    required this.label,
    required this.change,
    required this.svgPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 8),

          // Label and Change Percentage in one Row
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
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const Spacer(),
              Text(
                change,
                style: TextStyle(

                    color: change.startsWith('+') ? Colors.tealAccent : Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}