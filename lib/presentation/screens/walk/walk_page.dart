import 'package:fit_trac/presentation/screens/walk_page_folder/widgets/walk_activity_card.dart';
import 'package:fit_trac/presentation/screens/walk_page_folder/widgets/walk_buttons.dart';
import 'package:fit_trac/presentation/screens/walk_page_folder/widgets/walk_duration_selector.dart';
import 'package:fit_trac/presentation/screens/walk_page_folder/widgets/walk_info_card.dart';
import 'package:fit_trac/presentation/screens/walk_page_folder/widgets/walk_tab_selector.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';


class WalkScreen extends StatefulWidget {
  const WalkScreen({super.key});

  @override
  State<WalkScreen> createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  // Start 10-min Walk
  int selectedMinute = 10;

  // DurationSelector
  void _updateSelectedMinute(int minute) {
    setState(() {
      selectedMinute = minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1418),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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

            //  TAB SWITCHER & DURATION SELECTOR
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const WalkTabSelector(), // Separated tab switch

                  const SizedBox(height: 20),

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

                  //  MINUTE SCROLLER
                  WalkDurationSelector(
                    selectedMinute: selectedMinute,
                    onMinuteChanged: _updateSelectedMinute,
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "You'll get a notification when you're done.",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),

                  const SizedBox(height: 18),

                  //START TIMED WALK BUTTON
                  StartTimedWalkButton(selectedMinute: selectedMinute),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  TODAY'S ACTIVITY
            const WalkActivityCard(),

            const SizedBox(height: 20),

            // DID YOU KNOW CART
            const WalkInfoCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}