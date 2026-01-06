import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider ইম্পোর্ট
import '../../../../models/exercise_model.dart';
import '../../../../services/excercise_services.dart';
import '../../providers/exercise_provider.dart';
import 'freehand_preparation.dart';

class FreeHandExcerciseScreen extends StatefulWidget {
  final int subCategoryId;
  final String? categoryName;
  const FreeHandExcerciseScreen({super.key, required this.subCategoryId, this.categoryName});

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
    try {
      final service = ExerciseService();
      final data = await service.fetchExercises(widget.subCategoryId);

      if (mounted) {
        setState(() {
          exerciseItems = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
      debugPrint("Error loading exercises: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String appBarTitle = widget.categoryName ?? "Exercises";
    return Scaffold(
      backgroundColor: const Color(0xFF161B1F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF20262B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          appBarTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : exerciseItems.isEmpty
          ? const Center(
          child: Text("No exercises found",
              style: TextStyle(color: Colors.white54)))
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
        context.read<ExerciseProvider>().setSelectedExercise(item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PushUpDetailsScreen(exercise: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF20262B),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 60,
                  width: 60,
                  color: Colors.grey[800],
                  child: const Icon(Icons.fitness_center, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.target,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.play_circle_outline_rounded,
              color: Colors.teal,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}