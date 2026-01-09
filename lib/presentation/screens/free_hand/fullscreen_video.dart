import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../providers/video_player_provider.dart';

class FullScreenVideoPlayer extends StatelessWidget {
  final String title;
  const FullScreenVideoPlayer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<VideoPlayerProvider>(
        builder: (context, provider, child) {
          final controller = provider.controller;
          if (!provider.isInitialized || controller == null) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          }

          return Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        right: 20,
                        child: Row(
                          children: [
                            _buildCircleIcon(
                              controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                                  () => controller.setVolume(controller.value.volume == 0 ? 1 : 0),
                            ),
                            const SizedBox(width: 15),
                            _buildCircleIcon(Icons.fullscreen_exit, () => Navigator.pop(context)),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSkipIcon(Icons.replay_10, () {
                              controller.seekTo(controller.value.position - const Duration(seconds: 10));
                            }),
                            const SizedBox(width: 40),
                            GestureDetector(
                              onTap: () => provider.togglePlay(),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white24,
                                child: Icon(
                                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            _buildSkipIcon(Icons.forward_10, () {
                              controller.seekTo(controller.value.position + const Duration(seconds: 10));
                            }),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
                            ),
                            const SizedBox(height: 15),
                            VideoProgressIndicator(
                              controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.white,
                                bufferedColor: Colors.white24,
                                backgroundColor: Colors.white12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  provider.formatDuration(controller.value.position),
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  provider.formatDuration(controller.value.duration),
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white24,
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildSkipIcon(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 35),
      onPressed: onTap,
    );
  }
}