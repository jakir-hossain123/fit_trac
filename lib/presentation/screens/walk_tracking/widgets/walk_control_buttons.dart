import 'package:flutter/material.dart';
import '../walk_progress.dart';

class WalkControlButtons extends StatelessWidget {
  final TrackingState currentState;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onStop;

  const WalkControlButtons({
    super.key,
    required this.currentState,
    required this.onStart,
    required this.onPause,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    // Start
    final bool showStartOrResume = currentState != TrackingState.running;

    // Pause / Stop
    final bool showPauseOrStop =
        currentState == TrackingState.running || currentState == TrackingState.paused;

    // Start/Resume  level and icon
    IconData startIcon =
    currentState == TrackingState.paused ? Icons.play_arrow : Icons.directions_walk;

    String startLabel =
    currentState == TrackingState.paused ? "Resume" : "Start Walk";

    return Column(
      children: [
        // Start / Resume button
        if (showStartOrResume)
          ControlButton(
            icon: startIcon,
            label: startLabel,
            backgroundColor: Colors.teal[700]!,
            isFullWidth: true,
            onPressed: onStart,
          ),

        if (showStartOrResume && currentState == TrackingState.paused)
          const SizedBox(height: 16),

        // Pause + Stop Row
        if (showPauseOrStop)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ControlButton(
                    icon: Icons.pause,
                    label: "Pause",
                    backgroundColor: currentState == TrackingState.running
                        ? const Color(0xFF122027)
                        : Colors.grey[700]!,
                    onPressed: onPause,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ControlButton(
                    icon: Icons.stop_circle_outlined,
                    label: "Stop",
                    backgroundColor: Colors.red[700]!,
                    textColor: Colors.white,
                    onPressed: onStop,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

// Modern Design ControlButton
class ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool isFullWidth;
  final VoidCallback onPressed;

  const ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    this.textColor = Colors.white,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        elevation: 0,
        minimumSize: isFullWidth ? const Size(double.infinity, 50) : Size.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
