import 'package:fit_trac/presentation/screens/free_hand/work_out_video_player_screen.dart';
import 'package:flutter/material.dart';

class PushUpDetailsScreen extends StatefulWidget {
  const PushUpDetailsScreen({super.key});

  @override
  State<PushUpDetailsScreen> createState() => _PushUpDetailsScreenState();
}

class _PushUpDetailsScreenState extends State<PushUpDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFF20262B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Push Ups',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        image: AssetImage('assets/images/vid.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      _buildInfoTag('12 reps'),
                      const SizedBox(width: 8),
                      const Text('×', style: TextStyle(color: Colors.white54)),
                      const SizedBox(width: 8),
                      _buildInfoTag('3 sets'),
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
                  const Text(
                    'Read or watch the video before starting',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                  const SizedBox(height: 20),


                  _buildInstructionStep(
                    '1',
                    'Get into a high plank position with your hands slightly wider than your shoulders, arms straight.',
                  ),
                  _buildInstructionStep(
                    '2',
                    'Lower your body until your chest nearly touches the floor. Keep your back straight and core engaged.',
                  ),
                  _buildInstructionStep(
                    '3',
                    'Push back up to the starting position. That\'s one rep.',
                  ),
                ],
              ),
            ),
          ),

          // Start Workout button

             Container(decoration: BoxDecoration(
               color: Color(0xFF20262B),
               borderRadius: const BorderRadius.only(
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
                        MaterialPageRoute(builder: (context) => const WorkoutVideoPlayerScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E5A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon:  Icon(Icons.play_arrow_outlined, color: Colors.white, size: 25,),
                    label: const Text(
                      'Start Workout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF2A4156),
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
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