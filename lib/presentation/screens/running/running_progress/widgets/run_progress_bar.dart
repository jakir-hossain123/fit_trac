import 'package:flutter/material.dart';

// Colors and constants for the custom design, matching the WalkProgressBar
const Color _kBackgroundColor = Color(0xFF1C2226);
const Color _kTextColor = Colors.white;
const double _kBarHeight = 24.0;
const Color _kActiveColor = Color(0xFF4285F4);

class RunProgressBar extends StatelessWidget {
  final double progressValue;
  final String runType;
  final bool isRunning;
  final bool isPaused;
  final int timeElapsed;
  final double distance;

  const RunProgressBar({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.timeElapsed,
    required this.distance,
    required this.progressValue,
    required this.runType,
  });

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;
    double currentProgress = progressValue.clamp(0.0, 1.0);

    // Run/Pause
    if (isRunning && !isPaused) {
      statusText = "Progress: $runType";
      statusColor = _kActiveColor;
    } else if (isPaused) {
      statusText = "Paused: $runType";
      statusColor = Colors.orange;
    } else {
      statusText = "Ready to Run: $runType";
      statusColor = Colors.grey;
    }

    // Start: Custom Card Container
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _kBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  The Status Text
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          //  Custom Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(_kBarHeight / 2),
            child: SizedBox(
              height: _kBarHeight,
              child: Stack(
                children: [
                  // Background/Unfilled Track
                  Container(
                    width: double.infinity,
                    color: Colors.white10,
                  ),

                  // The Filled Progress Bar
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * currentProgress,
                          height: _kBarHeight,
                          decoration: BoxDecoration(

                            color: statusColor,
                          ),
                        ),
                      );
                    },
                  ),

                  // Percentage Text Overlay
                  Positioned.fill(
                    child: Center(
                      child: currentProgress > 0.05
                          ? Text(
                        '${(currentProgress * 100).toInt()}%',
                        style: const TextStyle(
                          color: _kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}