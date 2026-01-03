import 'package:fit_trac/presentation/screens/free_hand/work_out_video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../models/exercise_model.dart';


class PushUpDetailsScreen extends StatefulWidget {
  final ExerciseItem exercise;

  const PushUpDetailsScreen({super.key, required this.exercise});

  @override
  State<PushUpDetailsScreen> createState() => _PushUpDetailsScreenState();
}

class _PushUpDetailsScreenState extends State<PushUpDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.exercise.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.exercise.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      _buildInfoTag('${widget.exercise.duration}'),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Colors.white54)),
                      const SizedBox(width: 8),
                      _buildInfoTag(widget.exercise.target),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Instructions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),


                  Html(
                    data: widget.exercise.description,
                    style: {
                      "body": Style(color: Colors.white70, fontSize: FontSize(16)),
                      "p": Style(margin: Margins.only(bottom: 10)),
                    },
                  ),
                ],
              ),
            ),
          ),

          // Start Workout button
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF20262B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 47,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutVideoPlayerScreen(
                          exercise: widget.exercise,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E5A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 25),
                  label: const Text(
                    'Start Workout',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E282F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.blueAccent, fontSize: 13),
      ),
    );
  }
}