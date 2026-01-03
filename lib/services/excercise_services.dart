import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/exercise_model.dart';

class ExerciseService {
  static const String apiUrl = "http://188.166.224.141:8080/items/by-subcategory/1?page=0&page_size=10";

  Future<List<ExerciseItem>> fetchExercises() async {
    try {
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