import 'package:fit_trac/presentation/screens/free_hand/video_player_controls.dart';
import 'package:fit_trac/presentation/screens/free_hand/workout_stats.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'fullscreen_video.dart'; // Import your separate files

class WorkoutVideoPlayerScreen extends StatefulWidget {
  const WorkoutVideoPlayerScreen({super.key});
  @override
  State<WorkoutVideoPlayerScreen> createState() => _WorkoutVideoPlayerScreenState();
}

class _WorkoutVideoPlayerScreenState extends State<WorkoutVideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _startHideTimer();
      });
    _controller.addListener(() => setState(() {}));
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () => setState(() => _showControls = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12191D),
      appBar: AppBar(title: const Text("Push Ups"), backgroundColor: Colors.transparent),
      body: Column(
        children: [
          // Video Section
          GestureDetector(
            onTap: () => setState(() { _showControls = !_showControls; if(_showControls) _startHideTimer(); }),
            child: Container(
              height: 400,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.teal.withOpacity(0.5))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    VideoControlOverlay(
                      controller: _controller,
                      showControls: _showControls,
                      formatTime: formatDuration(_controller.value.position),
                      onTogglePlay: () => setState(() => _controller.value.isPlaying ? _controller.pause() : _controller.play()),
                      onFullscreen: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenVideoPlayer(controller: _controller, title: "Push Ups"))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const WorkoutStats(),
          const Spacer(),
        ],
      ),
    );
  }

  String formatDuration(Duration d) => "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  @override
  void dispose() { _controller.dispose(); _hideTimer?.cancel(); super.dispose(); }
}