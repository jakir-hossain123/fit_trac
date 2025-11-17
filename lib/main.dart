import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_trac/presentation/providers/auth_provider.dart';
import 'package:fit_trac/utils/app_theme.dart';
import 'package:fit_trac/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}