import 'package:flutter/cupertino.dart';
import '../../models/exercise_model.dart';
class ExerciseProvider extends ChangeNotifier {

  int? _subCategoryId;

  void setSubCategoryId(int id) {
    _subCategoryId = id;
    notifyListeners();
  }

  ExerciseItem? _selectedExercise;
  ExerciseItem? get selectedExercise => _selectedExercise;

  void setSelectedExercise(ExerciseItem exercise)
  {
    _selectedExercise = exercise;
    notifyListeners();
  }

}