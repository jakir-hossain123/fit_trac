import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../routes.dart';
import '../../../../services/history_service.dart';
import '../../../providers/exercise_provider.dart';
import '../../../providers/video_player_provider.dart';
import '../../running/runnign_summary/running_summery_grid.dart';

class PushUpSummary extends StatefulWidget {
  const PushUpSummary({super.key});

  @override
  State<PushUpSummary> createState() => _PushUpSummaryState();
}

class _PushUpSummaryState extends State<PushUpSummary> {
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    // Save data once the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveExerciseAndVideoSession();
    });
  }

  void _saveExerciseAndVideoSession() {
    if (_isSaved) return;

    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final videoProvider = Provider.of<VideoPlayerProvider>(context, listen: false);

    final exercise = exerciseProvider.selectedExercise;

    // Safe way to get seconds
    int watchTimeSeconds = 0;
    if (videoProvider.controller != null && videoProvider.controller!.value.isInitialized) {
      watchTimeSeconds = videoProvider.controller!.value.position.inSeconds;
    }

    if (exercise != null) {
      HistoryService.saveSession("Exercise", {
        'name': exercise.title,
        'sets': exercise.sets,
        'reps': exercise.reps,
        'time': watchTimeSeconds,
        'kcal': 209.0,
      });

      // 2. Persist Video Watching History separately
      HistoryService.saveSession("Video", {
        'videoTitle': exercise.title,
        'watchTimeSeconds': watchTimeSeconds,
        'category': 'Freehand Exercise',
      });

      if (mounted) {
        setState(() => _isSaved = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing providers to get real-time data
    final exercise = context.watch<ExerciseProvider>().selectedExercise;
    final videoProvider = context.watch<VideoPlayerProvider>();

    // Calculate formatted time from video position
    final duration = videoProvider.controller?.value.position ?? Duration.zero;
    final String formattedTime =
        "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')} min";

    const Color darkBackground = Color(0xFF0F1418);

    // Dynamic stat list mapped from Exercise and Video providers
    final List<SummaryStatData> dynamicStats = [
      SummaryStatData(
          value: '${exercise?.sets}/${exercise?.sets}',
          label: 'Sets',
          change: '+8%',
          svgPath: 'assets/icons/sets.svg',
          color: Colors.blueAccent
      ),
      SummaryStatData(
          value: '${exercise?.reps}',
          label: 'Reps',
          change: '+6%',
          svgPath: 'assets/icons/reps.svg',
          color: Colors.lightBlue
      ),
      SummaryStatData(
          value: formattedTime,
          label: 'Time',
          change: '-8%',
          svgPath: 'assets/icons/time.svg',
          color: Colors.amber
      ),
      SummaryStatData(
          value: '209',
          label: 'Calories',
          change: '+8%',
          svgPath: 'assets/icons/calories.svg',
          color: Colors.redAccent
      ),
    ];

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF12191D),
        elevation: 0,
        title: Text(
            "${exercise?.title ?? 'Exercise'} Summary",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.teal.withOpacity(0.3), width: 4),
                  ),
                  child: const Icon(Icons.check, color: Colors.tealAccent, size: 50),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "${exercise?.title ?? 'Exercise'} Complete!",
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Great Job! You've pushed through. Keep that momentum going.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              const SizedBox(height: 40),

              // Rendering the grid with dynamic data
              RunningSummeryGrid(stats: dynamicStats),

              const SizedBox(height: 60,),
              const Text("Up Next", style: TextStyle(color: Colors.white54, fontSize: 14)),
              const SizedBox(height: 5),
              const Text("Squats", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              _buildActionButtons(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF1E3A3A)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: const Text("Repeat", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF135D5A),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: const Text("Next", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}