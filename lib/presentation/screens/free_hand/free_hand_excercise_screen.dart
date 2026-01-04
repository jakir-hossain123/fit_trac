

import 'package:flutter/material.dart';

import '../../../models/exercise_model.dart';
import '../../../services/excercise_services.dart';
import 'freehand_preparation.dart';

class FreeHandExcerciseScreen extends StatefulWidget {
  const FreeHandExcerciseScreen({super.key});
  @override
  State<FreeHandExcerciseScreen> createState() => _FreeHandExcerciseScreenState();
}

class _FreeHandExcerciseScreenState extends State<FreeHandExcerciseScreen> {
  List<ExerciseItem> exerciseItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final data = await ExerciseService().fetchExercises();
    setState(() { exerciseItems = data; isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161B1F),
      appBar: AppBar(
        backgroundColor:Color(0xFF20262B),
          title: const Text("Exercises"), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: exerciseItems.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final item = exerciseItems[index];
          return _buildTile(item);
        },
      ),
    );
  }

  Widget _buildTile(ExerciseItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => PushUpDetailsScreen(exercise: item)
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF20262B), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(item.imageUrl, height: 60, width: 60, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.grey[800], child: const Icon(Icons.fitness_center))),
            ),
            const SizedBox(width: 15),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(item.target, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ])),
            Icon(Icons.play_circle_outline_rounded, color: Colors.teal.shade400, size: 30),

          ],
        ),
      ),
    );
  }
}