import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider ইম্পোর্ট
import '../../../../models/exercise_model.dart';
import '../../../../services/excercise_services.dart';
import '../../providers/exercise_provider.dart';
import 'freehand_preparation.dart'; // এখানে PushUpDetailsScreen আছে কিনা নিশ্চিত হোন

class FreeHandExcerciseScreen extends StatefulWidget {
  final int subCategoryId;
  const FreeHandExcerciseScreen({super.key, required this.subCategoryId});

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
    return Scaffold(
      backgroundColor: const Color(0xFF161B1F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF20262B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Exercises",
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
        // ১. প্রোভাইডারে ডাটা সেট করা (listen: false অবশ্যই দিতে হবে)
        context.read<ExerciseProvider>().setSelectedExercise(item);

        // ২. নেভিগেশন (এখন প্যারামিটার পাঠালেও সমস্যা নেই, না পাঠালেও প্রোভাইডার থেকে পাবে)
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