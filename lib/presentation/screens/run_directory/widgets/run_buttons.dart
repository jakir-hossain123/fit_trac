import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';
import '../../../../routes.dart';

// Start 10-min Run Button
class StartInstantRunButton extends StatelessWidget {
  const StartInstantRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.runProgress),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow,
                  color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Start 10-min Run",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                "Instant warm-up walk_tracking",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Start Timed Run Button
class StartTimedRunButton extends StatelessWidget {
  final int selectedMinute;

  const StartTimedRunButton({super.key, required this.selectedMinute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.runProgress),

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryTeal,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          "Start Timed Run ($selectedMinute min)",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}