import 'package:fit_trac/presentation/screens/free_hand/work_out_video_player_screen.dart';
import 'package:flutter/material.dart';
import '../../../models/exercise_model.dart';

class PushUpDetailsScreen extends StatelessWidget {
  final ExerciseItem exercise;
  const PushUpDetailsScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF161B1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          exercise.title,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      exercise.imageUrl,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 350,
                        color: Colors.grey[900],
                        child: const Icon(Icons.image, color: Colors.white24, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Info Tags (Reps & Sets)
                  Row(
                    children: [
                      _buildInfoTag('${exercise.reps} reps'),
                      const SizedBox(width: 8),
                      const Text('×', style: TextStyle(color: Colors.white54)),
                      const SizedBox(width: 8),
                      _buildInfoTag('${exercise.sets} sets'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Instructions',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Read or watch the video before starting',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  _buildInstructionStep('1', exercise.description),
                ],
              ),
            ),
          ),

          // Bottom Start Workout Button UI
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Color(0xFF20262B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WorkoutVideoPlayerScreen(exercise: exercise)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E5A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.play_arrow_outlined, color: Colors.white),
                label: const Text(
                  'Start Workout',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
      child: Text(text, style: const TextStyle(color: Colors.blueAccent, fontSize: 13)),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF2A4156),
            child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}