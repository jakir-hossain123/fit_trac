import 'package:fit_trac/presentation/providers/run_provider.dart';
import 'package:fit_trac/presentation/providers/walk_provider.dart';
import 'package:fit_trac/services/tracking_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_trac/utils/app_theme.dart';
import 'package:fit_trac/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalkProvider()),
        ChangeNotifierProvider(create: (_) => RunProvider()),
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
