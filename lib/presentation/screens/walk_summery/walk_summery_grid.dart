import 'package:flutter/material.dart';
import '../running/runnign_summary/running_summery_grid.dart';


class WalkSummaryGrid extends StatelessWidget {
  final List stats;

  const WalkSummaryGrid({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
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

