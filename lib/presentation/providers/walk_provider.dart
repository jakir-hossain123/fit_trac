import 'package:flutter/material.dart';

class WalkProvider extends ChangeNotifier {
  // State: The selected minute
  int _selectedMinute = 10;

  // Getter: To retrieve the value
  int get selectedMinute => _selectedMinute;

  // Method: To update the value and notify the UI
  void updateSelectedMinute(int minute) {
    _selectedMinute = minute;
    notifyListeners(); // This triggers the UI rebuild
  }
}