import 'package:fit_trac/presentation/screens/home/widgets/contant_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../utils/app_theme.dart';
import 'package:fit_trac/presentation/screens/home/widgets/home_header.dart';
import '../../../utils/activity_permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestActivityPermission();
  }

  void _requestActivityPermission() async {

    await requestActivityPermission();
  }


  static final List<Widget> _widgetOptions = <Widget>[
    const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: HomeHeader(),
        ),

        Expanded(
          child: HomeContent(),
        ),
      ],
    ),

    const Center(
      child: Text("Walk/Run Page Placeholder", style: TextStyle(color: Colors.white, fontSize: 24)),
    ),

    // History
    const Center(
      child: Text("History/Chart Page", style: TextStyle(color: Colors.white, fontSize: 24)),
    ),

    // Events
    const Center(
      child: Text("Events Page", style: TextStyle(color: Colors.white, fontSize: 24)),
    ),

    //  Profile
    const Center(
      child: Text("Profile Page", style: TextStyle(color: Colors.white, fontSize: 24)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,

      body: SafeArea(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),


      bottomNavigationBar: Container(
        color: AppTheme.inputFieldColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            gap: 8,
            activeColor: AppTheme.primaryTeal,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppTheme.primaryTeal.withOpacity(0.15),
            color: Colors.white54,

            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,

            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.directions_walk, text: 'Walk'),
              GButton(icon: Icons.pie_chart_rounded, text: 'History'),
              GButton(icon: Icons.emoji_events_outlined, text: 'Events'),
              GButton(icon: Icons.person_outline, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}