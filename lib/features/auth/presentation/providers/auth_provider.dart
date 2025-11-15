import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  // ---------------------------
  // SIGN IN (your existing logic)
  // ---------------------------
  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // fake delay for demo
    await Future.delayed(const Duration(seconds: 2));

    // after login success
    _isLoading = false;
    _isLoggedIn = true;
    notifyListeners();
  }

  // ---------------------------
  // LOGOUT (this fixes your error)
  // ---------------------------
  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }
}
