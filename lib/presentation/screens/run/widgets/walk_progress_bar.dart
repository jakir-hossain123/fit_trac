import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalkProgressBar extends StatelessWidget {
  const WalkProgressBar({super.key});


  final double progressValue = 0.6;
  final String walkType = "10 min walk";


  @override
  Widget build(BuildContext context) {
    final String progressSvgPath = 'assets/icons/Progress.svg';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF122027),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  progressSvgPath,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text.rich(
                  TextSpan(
                    text: "Progress ",
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                    children: [
                      TextSpan(
                        text: walkType,
                        style: const TextStyle(color: Colors.green, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            //  LinearProgressIndicator
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 27,
                    backgroundColor: const Color(0xFF1B2B33),
                    color: Colors.blueAccent,
                    // Purple color for the bar itself
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "${(progressValue * 100).toInt()}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}