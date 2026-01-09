import 'package:fit_trac/presentation/screens/free_hand/summery/work_out_summery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import '../../../models/exercise_model.dart';
import '../../providers/exercise_provider.dart';
import '../../providers/video_player_provider.dart'; // পাথ চেক করে নিন
import 'fullscreen_video.dart';

class WorkoutVideoPlayerScreen extends StatefulWidget {
  const WorkoutVideoPlayerScreen({super.key});

  @override
  State<WorkoutVideoPlayerScreen> createState() => _WorkoutVideoPlayerScreenState();
}

class _WorkoutVideoPlayerScreenState extends State<WorkoutVideoPlayerScreen> {
  bool _showControls = true;
  Timer? _hideTimer;
  ExerciseItem? exercise;

  @override
  void initState() {
    super.initState();
    exercise = Provider.of<ExerciseProvider>(context, listen: false).selectedExercise;

    if (exercise != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<VideoPlayerProvider>(context, listen: false)
            .initializeVideo(exercise!.videoUrl);
      });
    }
    _startHideTimer();
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

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (exercise == null) {
      return const Scaffold(backgroundColor: Color(0xFF161B1F), body: Center(child: Text("No Data")));
    }

    return Consumer<VideoPlayerProvider>(
      builder: (context, videoProvider, child) {
        final controller = videoProvider.controller;
        final isInit = videoProvider.isInitialized;

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
                  decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(18)),
                  height: 400, // আপনার আগের হাইট
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: _toggleControls,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isInit)
                            SizedBox.expand(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: controller!.value.size.width,
                                  height: controller.value.size.height,
                                  child: VideoPlayer(controller),
                                ),
                              ),
                            )
                          else
                            const Center(child: CircularProgressIndicator(color: Colors.teal)),

                          if (isInit)
                            Positioned.fill(
                              child: AnimatedOpacity(
                                opacity: _showControls ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  color: Colors.black45,
                                  child: Stack(
                                    children: [
                                      // Top Right Icons
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Row(
                                          children: [
                                            _buildCircleIcon(Icons.fullscreen, () {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => FullScreenVideoPlayer(title: exercise!.title),
                                              ));
                                            }),
                                            const SizedBox(width: 8),
                                            _buildCircleIcon(
                                              controller!.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                                                  () => controller.setVolume(controller.value.volume == 0 ? 1 : 0),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Center Play/Skip Controls
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            _buildSkipIcon(Icons.replay_10, () => controller.seekTo(controller.value.position - const Duration(seconds: 10))),
                                            const SizedBox(width: 15),
                                            GestureDetector(
                                              onTap: () => videoProvider.togglePlay(),
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.white24,
                                                child: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 30),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            _buildSkipIcon(Icons.forward_10, () => controller.seekTo(controller.value.position + const Duration(seconds: 10))),
                                          ],
                                        ),
                                      ),

                                      // Bottom Progress & Timer
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
                                              controller,
                                              allowScrubbing: true,
                                              colors: const VideoProgressColors(playedColor: Colors.white, bufferedColor: Colors.white24, backgroundColor: Colors.white12),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(videoProvider.formatDuration(controller.value.position), style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                Text(videoProvider.formatDuration(controller.value.duration), style: const TextStyle(color: Colors.white, fontSize: 12)),
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

              // Bottom Buttons (Next, End, Repeat)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOutlineButton("End", () => Navigator.pop(context)),
                    _buildElevatedButton("Next", () {
                      controller?.pause();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PushUpSummary()));
                    }),
                    _buildOutlineButton("Repeat", () => controller?.seekTo(Duration.zero)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Methods ---
  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: CircleAvatar(radius: 16, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 18)));
  Widget _buildSkipIcon(IconData icon, VoidCallback onTap) => IconButton(icon: Icon(icon, color: Colors.white, size: 28), onPressed: onTap);
  Widget _buildCounterTag(String reps, String sets) => Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF20262B), borderRadius: BorderRadius.circular(30)), child: Row(mainAxisSize: MainAxisSize.min, children: [Text(reps, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("×", style: TextStyle(color: Colors.white54))), Text(sets, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]));
  Widget _buildOutlineButton(String text, VoidCallback onTap) => OutlinedButton(onPressed: onTap, style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12)), child: Text(text, style: const TextStyle(color: Colors.white)));
  Widget _buildElevatedButton(String text, VoidCallback onTap) => ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E5A), shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)), child: Text(text, style: const TextStyle(color: Colors.white)));
}