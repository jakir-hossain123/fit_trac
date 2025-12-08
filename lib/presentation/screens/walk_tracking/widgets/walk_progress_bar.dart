import 'package:flutter/material.dart';

// Colors and constants for the custom design
const Color _kBackgroundColor = Color(0xFF1C2226); // Dark background of the card
const Color _kTextColor = Colors.white; // Color for text inside the bar
const double _kBarHeight = 24.0;
const Color _kActiveColor = Color(0xFF4285F4); // Bright blue for active status

class WalkProgressBar extends StatelessWidget {
  final double progressValue;
  final String walkType;
  final bool isRunning;
  final bool isPaused;
  final int timeElapsed;
  final double distance;

  const WalkProgressBar({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.timeElapsed,
    required this.distance,
    required this.progressValue,
    required this.walkType,
  });

  @override
  Widget build(BuildContext context) {
    // --- Status Logic (Determines header text and color) ---
    String statusText;
    Color statusColor;
    double currentProgress = progressValue.clamp(0.0, 1.0);

    if (isRunning && !isPaused) {
      statusText = "Progress: $walkType";
      statusColor = _kActiveColor;
    } else if (isPaused) {
      statusText = "Paused: $walkType";
      statusColor = Colors.orange;
    } else {
      statusText = "Ready to Walk: $walkType";
      statusColor = Colors.grey;
    }

    // --- Start: Custom Card Container (Dark background, rounded corners) ---
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _kBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. The Status Text (Header)
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12), // Spacing between header and bar

          // 2. Custom Progress Bar (Replacing LinearProgressIndicator)
          ClipRRect(
            borderRadius: BorderRadius.circular(_kBarHeight / 2), // Creates the pill shape
            child: SizedBox(
              height: _kBarHeight,
              child: Stack(
                children: [
                  // Background/Unfilled Track
                  Container(
                    width: double.infinity,
                    color: Colors.white10,
                  ),

                  // The Filled Progress Bar (Dynamic Width)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * currentProgress,
                          height: _kBarHeight,
                          decoration: BoxDecoration(
                            // Fill color changes based on the activity status
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