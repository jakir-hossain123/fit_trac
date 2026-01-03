import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../models/exercise_model.dart';
import 'html_content_page.dart';

class WorkoutVideoPlayerScreen extends StatefulWidget {
  final ExerciseItem exercise;
  const WorkoutVideoPlayerScreen({super.key, required this.exercise});

  @override
  State<WorkoutVideoPlayerScreen> createState() => _WorkoutVideoPlayerScreenState();
}

class _WorkoutVideoPlayerScreenState extends State<WorkoutVideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.exercise.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise.title)),
      body: Column(
        children: [
          Expanded(
            child: HtmlContentPage(data: widget.exercise.description),
          ),

        ],
      ),
    );
  }
}