import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControlOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showControls;
  final VoidCallback onTogglePlay;
  final VoidCallback onFullscreen;
  final String formatTime;

  const VideoControlOverlay({
    super.key,
    required this.controller,
    required this.showControls,
    required this.onTogglePlay,
    required this.onFullscreen,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.black38,
        child: Stack(
          children: [
            // Top Icons
            Positioned(
              top: 15,
              right: 15,
              child: Row(
                children: [
                  _circleIcon(Icons.fullscreen, onFullscreen),
                  const SizedBox(width: 10),
                  _circleIcon(
                    controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                        () => controller.setVolume(controller.value.volume == 0 ? 1 : 0),
                  ),
                ],
              ),
            ),
            // Center Play/Skip
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _skipIcon(Icons.replay_10, () => controller.seekTo(controller.value.position - const Duration(seconds: 10))),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: onTogglePlay,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black12,
                      child: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 45),
                    ),
                  ),
                  const SizedBox(width: 25),
                  _skipIcon(Icons.forward_10, () => controller.seekTo(controller.value.position + const Duration(seconds: 10))),
                ],
              ),
            ),
            // Bottom Info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Push Ups", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Upper Body", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text("$formatTime / ${formatDuration(controller.value.duration)}",
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  VideoProgressIndicator(controller, allowScrubbing: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _circleIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: CircleAvatar(radius: 18, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 20)),
  );

  Widget _skipIcon(IconData icon, VoidCallback onTap) => IconButton(icon: Icon(icon, color: Colors.white, size: 30), onPressed: onTap);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}