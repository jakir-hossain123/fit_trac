import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

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
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_videoListener);
    _startHideTimer();
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  // Timer logic to hide controls after 3 seconds
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  // Toggle controls visibility when screen is tapped
  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    widget.controller.removeListener(_videoListener);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // 1. Video Background
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

            // 2. Animated Control Layer
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black38, // Dim the background when controls are visible
                child: Stack(
                  children: [
                    // Top Controls
                    Positioned(
                      top: 50,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildCircleIcon(Icons.fullscreen_exit, () => Navigator.pop(context)),
                          const SizedBox(width: 10),
                          _buildCircleIcon(
                            widget.controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                                () => setState(() => widget.controller.setVolume(widget.controller.value.volume == 0 ? 1 : 0)),
                          ),
                        ],
                      ),
                    ),

                    // Center Play/Skip Controls
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSkipIcon(Icons.replay_10, () {
                            widget.controller.seekTo(widget.controller.value.position - const Duration(seconds: 10));
                            _startHideTimer(); // Reset timer on action
                          }),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              setState(() => widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play());
                              _startHideTimer(); // Reset timer on action
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
                            _startHideTimer(); // Reset timer on action
                          }),
                        ],
                      ),
                    ),

                    // Bottom Progress Info
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          const Text("Upper Body", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          const SizedBox(height: 15),
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
              ),
            ),
          ],
        ),
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
    return IconButton(icon: Icon(icon, color: Colors.white, size: 35), onPressed: onTap);
  }
}