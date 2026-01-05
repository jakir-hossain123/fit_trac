import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise_model.dart';

class ExerciseService {
  static const String baseUrl = "http://188.166.224.141/items/by-subcategory";

  // এখানে (int subCategoryId) যোগ করা হয়েছে
  Future<List<ExerciseItem>> fetchExercises(int subCategoryId) async {
    try {
      final String apiUrl = "$baseUrl/$subCategoryId?page=0&page_size=10";

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data['data']['data'];
        return list.map((item) => ExerciseItem.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    }
    return [];
  }
}