import 'package:fit_trac/presentation/utils/core/app_theme.dart';
import 'package:fit_trac/presentation/utils/core/routes.dart';
import 'package:flutter/material.dart';


void main() {
  // Removed MultiProvider as we don't need AuthProvider state management yet.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: AppTheme.darkTheme,
      // Use the centralized routes map
      routes: AppRoutes.routes,
      // Set the initial route to the Home Page
      initialRoute: AppRoutes.home,
    );
  }
}