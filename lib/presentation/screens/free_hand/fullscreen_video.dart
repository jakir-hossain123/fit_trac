import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;

  const FullScreenVideoPlayer({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  // Helper to format duration to MM:SS
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    // Add listener to update UI when video position changes
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Main Video Background
          Center(
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: widget.controller.value.size.width,
                  height: widget.controller.value.size.height,
                  child: VideoPlayer(widget.controller),
                ),
              ),
            ),
          ),

          // 2. Top Controls (Close and Mute buttons)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildCircleIcon(Icons.fullscreen,  () => Navigator.pop(context)),
                const SizedBox(width: 5,),
                _buildCircleIcon(
                  widget.controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                      () {
                    setState(() {
                      widget.controller.setVolume(widget.controller.value.volume == 0 ? 1 : 0);
                    });
                  },
                ),
              ],
            ),
          ),

          // 3. Center Controls (Play/Pause/Skip)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSkipIcon(Icons.replay_10, () {
                  widget.controller.seekTo(widget.controller.value.position - const Duration(seconds: 10));
                }),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.value.isPlaying
                          ? widget.controller.pause()
                          : widget.controller.play();
                    });
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                _buildSkipIcon(Icons.forward_10, () {
                  widget.controller.seekTo(widget.controller.value.position + const Duration(seconds: 10));
                }),
              ],
            ),
          ),

          // 4. Bottom Info and Progress Bar
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
                ),
                const Text("Upper Body",
                    style: TextStyle(color: Colors.white70, fontSize: 16)
                ),
                const SizedBox(height: 15),

                // Duration Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}",
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Rounded Progress Bar
                SizedBox(
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoProgressIndicator(
                      widget.controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.white24,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable circle icon button
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

  // Reusable skip icon button
  Widget _buildSkipIcon(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 35),
      onPressed: onTap,
    );
  }
}