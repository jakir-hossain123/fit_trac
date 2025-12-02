import 'package:flutter/material.dart';
import '../../../../utils/app_theme.dart';
import '../../../../routes.dart';
import '../model/tracking_goal.dart';

// Start Distance Walk Button
class StartDistanceWalkButton extends StatelessWidget {
  final int selectedDistance;

  const StartDistanceWalkButton({super.key, required this.selectedDistance});

  @override
  Widget build(BuildContext context) {
    // Convert meters to km for display
    final String distanceKm = (selectedDistance / 1000)
        .toStringAsFixed(selectedDistance % 1000 == 0 ? 0 : 1);

    return GestureDetector(
      onTap: () {
        // Create Distance Goal
        final goal = TrackingGoal(
          type: GoalType.distance,
          targetValue: selectedDistance, // meter based
        );

        // Navigate with Goal Object
        Navigator.of(context).pushNamed(
          AppRoutes.walkProgressPage,
          arguments: goal,
        );
      },

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          "Start Distance Walk ($distanceKm km)",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
