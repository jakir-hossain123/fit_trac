import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../routes.dart';
import '../../../../utils/app_theme.dart';
import '../../../../utils/app_assets.dart';

class ExerciseGrid extends StatelessWidget {
  const ExerciseGrid({super.key});

  @override
  Widget build(BuildContext context) {

    final exercises = [
      {"label": "Freehand", "icon": AppAssets.freehandIcon},
      {"label": "Walk", "icon": AppAssets.stepIcon},
      {"label": "Run", "icon": AppAssets.stepIcon},
      {"label": "Swim", "icon": AppAssets.swimIcon},
      {"label": "Cycling", "icon": AppAssets.cyclingIcon},
      {"label": "Yoga", "icon": AppAssets.yogaIcon},
    ];

    return Container(
      // Card-style background and border radius
      decoration: BoxDecoration(
        color: AppTheme.inputFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row 1 (Freehand, Walk)
            Row(
              children: [
                Expanded(child: _buildExerciseButton(exercises[0]["label"]!, exercises[0]["icon"]!)),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.walkPage),
                      child: _buildExerciseButton(exercises[1]["label"]!, exercises[1]["icon"]!)),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Row 2 (Run, Swim)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.runPage) ,
                      child: _buildExerciseButton(exercises[2]["label"]!, exercises[2]["icon"]!)),
                ),
                const SizedBox(width: 15),
                Expanded(child: _buildExerciseButton(exercises[3]["label"]!, exercises[3]["icon"]!)),
              ],
            ),
            const SizedBox(height: 15),

            // Row 3 (Cycling, Yoga)
            Row(
              children: [
                Expanded(child: _buildExerciseButton(exercises[4]["label"]!, exercises[4]["icon"]!)),
                const SizedBox(width: 15),
                Expanded(child: _buildExerciseButton(exercises[5]["label"]!, exercises[5]["icon"]!)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseButton(String label, String iconPath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        // Button background color (like Quick Start button)
        color: AppTheme.primaryTeal,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon color set to White
          SvgPicture.asset(iconPath, height: 20, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}