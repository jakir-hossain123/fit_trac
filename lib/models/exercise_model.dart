import 'dart:convert';
import 'package:http/http.dart' as http;

class ExerciseItem {
  final int id;
  final String title;
  final String videoUrl;
  final String imageUrl;
  final String description;
  final String duration;
  final String target;
  final int sets;
  final int reps;

  ExerciseItem({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.target,
    required this.sets,
    required this.reps,

  });

  factory ExerciseItem.fromJson(Map<String, dynamic> json) {
    const String fileBase = "http://188.166.224.141:8080/files/";
    return ExerciseItem(
      id: json['id'],
      title: json['title'] ?? "",
      videoUrl: "$fileBase${json['video']}",
      imageUrl: "$fileBase${json['image']}",
      description: json['description'] ?? "",
      duration: "${json['duration'] ?? 0} min",
      target: json['targetDescription'] ?? "",
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
    );
  }
}

