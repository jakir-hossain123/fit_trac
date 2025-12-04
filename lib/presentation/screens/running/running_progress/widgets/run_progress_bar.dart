import 'package:flutter/material.dart';

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

    // Status Logic
    String statusText;
    Color statusColor;
    double currentProgress = progressValue.clamp(0.0, 1.0);

    if (isRunning && !isPaused) {
      statusText = "Currently Running: $runType";
      statusColor = Colors.teal;
    } else if (isPaused) {
      statusText = "Paused: $runType";
      statusColor = Colors.orange;
    } else {
      statusText = "Ready to Run: $runType";
      statusColor = Colors.grey;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        LinearProgressIndicator(
          minHeight: 8,
          backgroundColor: Colors.blueAccent,

          value: currentProgress,
          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
        ),
        const SizedBox(height: 8),
        Text(
          statusText,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}