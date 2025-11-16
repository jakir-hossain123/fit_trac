import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/core/app_theme.dart';
import '../utils/core/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _handleGoToSignIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.signIn,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 25),
                  _buildDailyGoalCard(),
                  const SizedBox(height: 25),
                  _buildStatsRow(),
                  const SizedBox(height: 25),
                  const Text(
                    "Start Exercise",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildExerciseButtons(),
                  const SizedBox(height: 30),
                  const Text(
                    "Weekly Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildWeeklyProgressChart(),
                ],
              ),
            ),

            // SIGN OUT/NAVIGATE BUTTON
            Positioned(
              top: 15,
              right: 5,
              child: IconButton(
                icon: Icon(Icons.logout, size: 24, color: Colors.teal.shade300),
                onPressed: () => _handleGoToSignIn(context),
                tooltip: 'Go to Sign In',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                "assets/images/user.png",
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning!",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  "John Doe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.notifications_none, size: 30, color: Colors.teal.shade800),
      ],
    );
  }

  Widget _buildDailyGoalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.inputFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Daily Goal",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              SizedBox(width: 11),
              Text(
                "30 min workout",
                style: TextStyle(color: AppTheme.primaryTeal, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: const LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: Colors.white10,
                  color: Colors.blue,
                  minHeight: 35,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 7.0),
                  child: Text(
                    "80%",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  "Quick Start",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard("Calories", "843 Kcal", "+6%", Colors.greenAccent),
        const SizedBox(width: 15),
        _statCard("Time", "3h 29min", "-8%", Colors.redAccent),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    String change,
    Color changeColor,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.inputFieldColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(width: 10),
                Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseButtons() {
    final exercises = [
      {"label": "Freehand", "icon": "assets/icons/Freehand.svg"},
      {"label": "Walk", "icon": "assets/icons/Freehand.svg"},
      {"label": "Run", "icon": "assets/icons/step.svg"},
      {"label": "Swim", "icon": "assets/icons/Swim.svg"},
      {"label": "Cycling", "icon": "assets/icons/Cycling.svg"},
      {"label": "Yoga", "icon": "assets/icons/Yoga.svg"},
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 17,
      children:
          exercises
              .map((e) => _buildExerciseButton(e["label"]!, e["icon"]!))
              .toList(),
    );
  }

  Widget _buildExerciseButton(String label, String iconPath) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 18, color: Colors.tealAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgressChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.inputFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset("assets/images/chart.png"),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppTheme.inputFieldColor,
      selectedItemColor: AppTheme.primaryTeal,
      unselectedItemColor: Colors.white54,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: "Stats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
