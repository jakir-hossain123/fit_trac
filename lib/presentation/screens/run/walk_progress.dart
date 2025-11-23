import 'package:fit_trac/presentation/screens/walk_progress_page/widgets/walk_control_buttons.dart';
import 'package:fit_trac/presentation/screens/walk_progress_page/widgets/walk_map_view.dart';
import 'package:fit_trac/presentation/screens/walk_progress_page/widgets/walk_progress_bar.dart';
import 'package:fit_trac/presentation/screens/walk_progress_page/widgets/walk_start_grid.dart';
import 'package:flutter/material.dart';
import '../../../routes.dart';



class WalkProgressScreen extends StatelessWidget {
  const WalkProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom dark background color
    const Color darkBackground = Color(0xFF0F1418);

    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false );
          },
        ),
        title: const Text(
          "Walking!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // jakir
            //
            // Map View
            WalkMapView(),
            SizedBox(height: 16),

            //  Progress Bar
            WalkProgressBar(),
            SizedBox(height: 20),

            // Stats Grid
            WalkStatsGrid(),
            SizedBox(height: 30),

            // Control Buttons
            WalkControlButtons(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}