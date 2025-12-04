import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';

// Start Distance Run Button
class StartDistanceRunButton extends StatelessWidget {
  final int selectedDistance;

  const StartDistanceRunButton({super.key, required this.selectedDistance});

  @override
  Widget build(BuildContext context) {
    final String distanceKm = (selectedDistance / 1000).toStringAsFixed(selectedDistance % 1000 == 0 ? 0 : 1);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: Text(
        "Start Distance Run ($distanceKm km)",
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}