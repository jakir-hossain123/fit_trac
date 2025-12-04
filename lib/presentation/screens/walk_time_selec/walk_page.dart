import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_activity_card.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_buttons.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_distance_button.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_distance_selector.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_duration_selector.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_info_card.dart';
import 'package:fit_trac/presentation/screens/walk_time_selec/widgets/walk_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../providers/walk_provider.dart';

class WalkScreen extends StatefulWidget {
  const WalkScreen({super.key});

  @override
  State<WalkScreen> createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  // State to track(Time = true, Distance = false)
  bool _isTimeSelected = true;

  // State for Distance selection
  int _selectedDistance = 1000;

  void _onTabSelected(bool isTime) {
    setState(() {
      _isTimeSelected = isTime;
    });
  }

  void _updateSelectedDistance(int distance) {
    setState(() {
      _selectedDistance = distance;
    });
  }


  @override
  Widget build(BuildContext context) {
    // WalkProvider for minute selection remains here
    final selectedMinute = context.select<WalkProvider, int>((p) => p.selectedMinute);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1418),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
        ),
        title: const Text(
          "Let's Walk!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // START 10-MIN BUTTON
            const StartInstantWalkButton(),
            const SizedBox(height: 20),

            // TAB SWITCHER & DURATION/DISTANCE SELECTOR
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  WalkTabSelector(
                    isTimeSelected: _isTimeSelected,
                    onTabSelected: _onTabSelected,
                  ),
                  const SizedBox(height: 20),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isTimeSelected
                        ? _buildTimeContent(context, selectedMinute)
                        : _buildDistanceContent(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // TODAY'S ACTIVITY
            const WalkActivityCard(),
            const SizedBox(height: 20),
            // DID YOU KNOW CARD
            const WalkInfoCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  //  method for Time content
  Widget _buildTimeContent(BuildContext context, int selectedMinute) {
    return Column(
      key: const ValueKey('TimeContent'),
      children: [
        const Text(
          "Walk Duration",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        const Text(
          "Scroll to choose minutes",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 14),
        WalkDurationSelector(
          selectedMinute: selectedMinute,
          onMinuteChanged: (minute) {
            context.read<WalkProvider>().updateSelectedMinute(minute);
          },
        ),
        const SizedBox(height: 10),
        const Text(
          "You'll get a notification when you're done.",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 18),
        StartTimedWalkButton(selectedMinute: selectedMinute),
      ],
    );
  }

  // Helper method for Distance content (new content)
  Widget _buildDistanceContent() {
    return Column(
      key: const ValueKey('DistanceContent'),
      children: [
        const Text(
          "Walk Distance",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        const Text(
          "Scroll to choose meters",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 14),
        // Distance Selector
        WalkDistanceSelector(
          selectedDistance: _selectedDistance,
          onDistanceChanged: _updateSelectedDistance,
        ),
        const SizedBox(height: 10),
        const Text(
          "You'll get a notification when you reach the target.",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 18),
        // Distance Button
        StartDistanceWalkButton(selectedDistance: _selectedDistance),
      ],
    );
  }
}