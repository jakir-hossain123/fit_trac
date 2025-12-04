import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';

class DailyGoalCard extends StatelessWidget {
  const DailyGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.inputFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Daily Goal",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              SizedBox(width: 11),
              Text(
                "30 min workout",
                style: TextStyle(color: AppTheme.primaryTeal, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: const LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: Colors.white10,
                  color: Colors.blue,
                  minHeight: 35,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 7.0),
                  child: Text(
                    "80%",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  "Quick Start",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}