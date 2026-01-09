import 'package:fit_trac/presentation/screens/free_hand/summery/work_out_summery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import '../../../models/exercise_model.dart';
import '../../providers/exercise_provider.dart';
import 'fullscreen_video.dart';

class WorkoutVideoPlayerScreen extends StatefulWidget {

  const WorkoutVideoPlayerScreen({super.key});

  @override
  State<WorkoutVideoPlayerScreen> createState() => _WorkoutVideoPlayerScreenState();
}

class _WorkoutVideoPlayerScreenState extends State<WorkoutVideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _showControls = true;
  Timer? _hideTimer;
  ExerciseItem? exercise;

  @override
  void initState() {
    super.initState();

    exercise = Provider.of<ExerciseProvider>(context, listen: false).selectedExercise;

    if (exercise != null) {
      _initializeVideo();
    }
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(exercise!.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller?.play();
        }
      });
    _controller?.addListener(_videoListener);
    _startHideTimer();
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _startHideTimer();
  }
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (exercise == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF161B1F),
        body: Center(child: Text("No Exercise Data Found", style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF161B1F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF161B1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(exercise!.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(18)
              ),
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: _toggleControls,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_controller != null && _controller!.value.isInitialized)
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller!.value.size.width,
                              height: _controller!.value.size.height,
                              child: VideoPlayer(_controller!),
                            ),
                          ),
                        )
                      else
                        const Center(child: CircularProgressIndicator(color: Colors.teal)),

                      if (_controller != null && _controller!.value.isInitialized)
                        Positioned.fill(
                          child: AnimatedOpacity(
                            opacity: _showControls ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              color: Colors.black45,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        _buildCircleIcon(Icons.fullscreen, () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => FullScreenVideoPlayer(
                                              controller: _controller!,
                                              title: exercise!.title,
                                            ),
                                          ));
                                        }),
                                        const SizedBox(width: 8),
                                        _buildCircleIcon(
                                          _controller!.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                                              () => setState(() => _controller!.setVolume(_controller!.value.volume == 0 ? 1 : 0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildSkipIcon(Icons.replay_10, () => _controller!.seekTo(_controller!.value.position - const Duration(seconds: 10))),
                                        const SizedBox(width: 15),
                                        GestureDetector(
                                          onTap: () => setState(() => _controller!.value.isPlaying ? _controller!.pause() : _controller!.play()),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white24,
                                            child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 30),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        _buildSkipIcon(Icons.forward_10, () => _controller!.seekTo(_controller!.value.position + const Duration(seconds: 10))),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(exercise!.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                        const SizedBox(height: 5),
                                        VideoProgressIndicator(
                                          _controller!,
                                          allowScrubbing: true,
                                          colors: const VideoProgressColors(playedColor: Colors.white, bufferedColor: Colors.white24, backgroundColor: Colors.white12),

                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatDuration(_controller!.value.position),
                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                            Text(
                                              _formatDuration(_controller!.value.duration),
                                              style: const TextStyle(color: Colors.white, fontSize: 12),
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
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          _buildCounterTag('${exercise!.reps} rep', '${exercise!.sets} set'),

          const Spacer(),
          const Text("Up Next", style: TextStyle(color: Colors.white54, fontSize: 12)),
          const Text("Squats", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOutlineButton("End", () => Navigator.pop(context)),
                _buildElevatedButton("Next", () {
                  _controller?.pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PushUpSummary()),
                  );
                }),
                _buildOutlineButton("Repeat", () => _controller?.seekTo(Duration.zero)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(radius: 16, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 18)),
    );
  }

  Widget _buildSkipIcon(IconData icon, VoidCallback onTap) {
    return IconButton(icon: Icon(icon, color: Colors.white, size: 28), onPressed: onTap);
  }

  Widget _buildCounterTag(String reps, String sets) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFF20262B), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(reps, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("×", style: TextStyle(color: Colors.white54))),
          const SizedBox(width: 4),
          Text(sets, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOutlineButton(String text, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildElevatedButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E5A), shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}