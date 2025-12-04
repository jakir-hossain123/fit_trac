import 'package:fit_trac/presentation/screens/run_directory/widgets/run_actively_card.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_buttons.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_distance_button.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_distance_selector.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_duration_selector.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_info_card.dart';
import 'package:fit_trac/presentation/screens/run_directory/widgets/run_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../providers/run_provider.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  bool _isTimeSelected = true;
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
    final selectedMinute = context.select<RunProvider, int>((p) => p.selectedMinute);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1418),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
        ),
        title: const Text(
          "Let's Run!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StartInstantRunButton(),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  RunTabSelector(
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
            const RunActivityCard(),
            const SizedBox(height: 20),
            const RunInfoCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeContent(BuildContext context, int selectedMinute) {
    return Column(
      key: const ValueKey('TimeContent'),
      children: [
        const Text(
          "Run Duration", // Changed Text
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
        RunDurationSelector( // Changed Widget Name
          selectedMinute: selectedMinute,
          onMinuteChanged: (minute) {
            context.read<RunProvider>().updateSelectedMinute(minute);
          },
        ),
        const SizedBox(height: 10),
        const Text(
          "You'll get a notification when you're done.",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 18),
        StartTimedRunButton(selectedMinute: selectedMinute), // Changed Widget Name
      ],
    );
  }

  Widget _buildDistanceContent() {
    return Column(
      key: const ValueKey('DistanceContent'),
      children: [
        const Text(
          "Run Distance",
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
        RunDistanceSelector(
          selectedDistance: _selectedDistance,
          onDistanceChanged: _updateSelectedDistance,
        ),
        const SizedBox(height: 10),
        const Text(
          "You'll get a notification when you reach the target.",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 18),
        StartDistanceRunButton(selectedDistance: _selectedDistance), // Changed Widget Name
      ],
    );
  }
}