import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/sub_catagory_model.dart';

Future<List<SubCategoryModel>> fetchSubCategories(int categoryId) async {
  final response = await http.get(Uri.parse('http://188.166.224.141/sub-categories/by-category/$categoryId'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> list = data['data'];
    return list.map((json) => SubCategoryModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load subcategories');
  }
}