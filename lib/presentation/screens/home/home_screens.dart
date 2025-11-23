import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_theme.dart';
import '../../routes.dart';
import '../../utils/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    //  Home Page Content
    const _HomeContent(),
    // Stats Page Content
    const Center(child: Text("📊 Statistics Page", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
    // 2: Profile Page Content
    const Center(child: Text("👤 Profile Page", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
    // 3: Map View Placeholder
    const SizedBox.shrink(),
  ];



  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.of(context).pushNamed(AppRoutes.walkPage);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _handleGoToSignIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.signIn,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFloatingButton = _selectedIndex == 0;

    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,

      floatingActionButton: showFloatingButton ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 1. Walk Progress Page
          FloatingActionButton(
            heroTag: 'progressBtn',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.walkProgressPage);
            },
            backgroundColor: Colors.teal.shade700,
            tooltip: 'Go to Progress',
            child: const Icon(Icons.show_chart, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 16),

          // 2. Walk Map Page
          FloatingActionButton(
            heroTag: 'mapBtn',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.walkPage);
            },
            backgroundColor: Colors.teal,
            tooltip: 'Go to Walk Map',
            child: const Icon(Icons.map, size: 28, color: Colors.white),
          ),
        ],) : null,

      body: SafeArea(
        child: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),


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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppTheme.inputFieldColor,
      selectedItemColor: AppTheme.primaryTeal,
      unselectedItemColor: Colors.white54,
      showUnselectedLabels: true,

      currentIndex: _selectedIndex,
      onTap: _onItemTapped,

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
        BottomNavigationBarItem(icon: Icon(Icons.map),
            label: "go_to_map"
        )
      ],
    );
  }
}



class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
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
          const SizedBox(height: 80),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                AppAssets.userImage,
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
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 40.0),
          child: Icon(Icons.notifications_none, size: 30, color: Colors.teal.shade800),
        ),
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
    // AppAssets
    final exercises = [
      {"label": "Freehand", "icon": AppAssets.freehandIcon},
      {"label": "Walk", "icon": AppAssets.stepIcon},
      {"label": "Run", "icon": AppAssets.stepIcon},
      {"label": "Swim", "icon": AppAssets.swimIcon},
      {"label": "Cycling", "icon": AppAssets.cyclingIcon},
      {"label": "Yoga", "icon": AppAssets.yogaIcon},
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
      child: Image.asset(AppAssets.chart),
    );
  }
}