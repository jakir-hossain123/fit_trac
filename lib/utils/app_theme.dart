import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDarkColor = Color(0xFF111518);
  static const Color inputFieldColor = Color(0xFF1E2429);
  static const Color primaryTeal = Colors.teal;

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryDarkColor,
    primaryColor: primaryTeal,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    ),
  );
}