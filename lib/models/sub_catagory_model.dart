class SubCategoryModel {
  final int id;
  final String name;
  final String description;
  final String targetDescription;
  final int sets;
  final int reps;
  final String imageUrl;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.targetDescription,
    required this.sets,
    required this.reps,
    required this.imageUrl,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      targetDescription: json['targetDescription'],
      sets: json['sets'],
      reps: json['reps'],
      imageUrl: "http://188.166.224.141/files/${json['image']}",
    );
  }
}