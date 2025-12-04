import 'package:flutter/material.dart';

class RunControlButtons extends StatelessWidget {
  final bool isRunning;
  final bool isPaused;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  const RunControlButtons({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRunning) {
      return ControlButton(
        icon: Icons.play_arrow,
        label: "Start Run",
        backgroundColor: Colors.teal[700]!,
        textColor: Colors.white,
        isFullWidth: true,
        onPressed: onStart,
      );
    }

    return Column(
      children: [
        // Pause/Resume - Lap
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: isPaused
                    ? ControlButton(
                  icon: Icons.play_arrow,
                  label: "Resume",
                  backgroundColor: Colors.green[700]!,
                  onPressed: onResume,
                )
                    : ControlButton(
                  icon: Icons.pause,
                  label: "Pause",
                  backgroundColor: const Color(0xFF122027),
                  onPressed: onPause,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ControlButton(
                  icon: Icons.refresh,
                  label: "Lap",
                  backgroundColor: const Color(0xFF122027),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Stop button
        ControlButton(
          icon: Icons.stop_circle_outlined,
          label: "Stop",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          isFullWidth: true,
          onPressed: onStop,
        ),
      ],
    );
  }
}

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