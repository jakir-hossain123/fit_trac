import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/app_assets.dart';
import 'daily_goal_card.dart';
import 'exercise_grid.dart';
import 'home_state_row.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DailyGoalCard(),
          const SizedBox(height: 25),

          const HomeStatsRow(),
          const SizedBox(height: 25),

          const Text(
            "Start Exercise",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          const ExerciseGrid(),

          const SizedBox(height: 30),
          const Text(
            "Weekly Progress",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Simple chart image
          Image.asset(AppAssets.chart),
          const SizedBox(height: 20),

          // Ensure this asset path is correct or use AppAssets
          SvgPicture.asset("assets/icons/run_card.svg"),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}