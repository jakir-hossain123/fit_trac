import 'package:flutter/material.dart';

class RunProvider extends ChangeNotifier {
  int _selectedMinute = 30;

  int get selectedMinute => _selectedMinute;

  void updateSelectedMinute(int minute) {
    if (_selectedMinute != minute) {
      _selectedMinute = minute;
      notifyListeners();
    }
  }


}