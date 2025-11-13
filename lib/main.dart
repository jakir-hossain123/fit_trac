import 'package:fit_trac/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'app/di_container.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/sign_in_page.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
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
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111518),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal.shade900,
          brightness: Brightness.dark,
        ),
      ),
      home: SignInPage(),
    );
  }
}
