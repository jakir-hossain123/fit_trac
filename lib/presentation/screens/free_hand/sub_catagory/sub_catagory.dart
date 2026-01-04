import 'package:flutter/material.dart';
import '../../../../models/sub_catagory_model.dart';
import '../../../../routes.dart';
import '../../../../services/sub_catagory_survice.dart';

class SubCatagory extends StatefulWidget {
  const SubCatagory({super.key});

  @override
  State<SubCatagory> createState() => _SubCatagoryState();
}

class _SubCatagoryState extends State<SubCatagory> {
  List<SubCategoryModel> subCategories = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSubCategories();
  }

  void _loadSubCategories() async {
    try {
      final data = await fetchSubCategories(2);
      if (mounted) {
        setState(() {
          subCategories = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      debugPrint("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF161B1F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF20262B),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          title: const Text("Freehand Exercises",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.teal))
            : subCategories.isEmpty
            ? const Center(child: Text("No data found", style: TextStyle(color: Colors.white)))
            : Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                const SizedBox(height: 30),

                // --- Workout of the Day (Fixed Section) ---
                _buildSectionHeader("Workout of the day", "Complete workout plan for the whole body"),
                const SizedBox(height: 20),
                _buildWorkoutOfTheDay(subCategories[0]), // প্রথম ডাটাটি এখানে পাঠাচ্ছি

                const SizedBox(height: 32),

                // --- Sub-Categories List ---
                _buildSectionHeader("Exercises", "Choose your workout"),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {
                    return _buildDynamicExerciseTile(subCategories[index]);
                  },
                ),
                const SizedBox(height: 37),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ১. Workout of the Day - ডিজাইন ফিক্সড, ইমেজ এপিআই থেকে
  Widget _buildWorkoutOfTheDay(SubCategoryModel item) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            item.imageUrl,
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 350,
              color: Colors.grey[900],
              child: const Icon(Icons.fitness_center, color: Colors.white, size: 50),
            ),
          ),
        ),
        // ইমেজের ওপর শ্যাডো ইফেক্ট
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("${item.sets} Sets x ${item.reps} Reps", style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.freeHand),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text("Start Workout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E6E6D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ২. লিস্ট আইটেম ডিজাইন
  Widget _buildDynamicExerciseTile(SubCategoryModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF20262B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              height: 60, width: 60, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.fitness_center, color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(item.description, style: const TextStyle(color: Colors.white54, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(Icons.play_circle_outline_rounded, color: Colors.teal.shade400, size: 30),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      focusNode: _searchFocusNode,
      controller: searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search exercise...",
        hintStyle: const TextStyle(color: Colors.white24),
        suffixIcon: const Icon(Icons.search, color: Colors.white24),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white24)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.teal)),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        Text(subTitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}