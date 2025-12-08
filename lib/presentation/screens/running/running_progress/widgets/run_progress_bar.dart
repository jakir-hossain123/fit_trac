import 'package:flutter/material.dart';

// Colors and constants for the custom design, matching the WalkProgressBar
const Color _kBackgroundColor = Color(0xFF1C2226); // কার্ডের ডার্ক ব্যাকগ্রাউন্ড
const Color _kTextColor = Colors.white; // বারের ভেতরের টেক্সটের রঙ
const double _kBarHeight = 24.0; // বারের উচ্চতা
const Color _kActiveColor = Color(0xFF4285F4); // অ্যাক্টিভ স্ট্যাটাসের জন্য উজ্জ্বল নীল রঙ

class RunProgressBar extends StatelessWidget {
  final double progressValue;
  final String runType; // লক্ষ্যের প্রকারভেদ (যেমন: "30 min run")
  final bool isRunning;
  final bool isPaused;
  final int timeElapsed;
  final double distance;

  const RunProgressBar({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.timeElapsed,
    required this.distance,
    required this.progressValue,
    required this.runType,
  });

  @override
  Widget build(BuildContext context) {
    // --- Status Logic (স্ট্যাটাস অনুযায়ী হেডার টেক্সট এবং রঙ নির্ধারণ) ---
    String statusText;
    Color statusColor;
    double currentProgress = progressValue.clamp(0.0, 1.0);

    // Run/Pause স্ট্যাটাস অনুযায়ী লজিক
    if (isRunning && !isPaused) {
      statusText = "Progress: $runType"; // প্রগ্রেস স্ট্যাটাস দেখাচ্ছে
      statusColor = _kActiveColor;
    } else if (isPaused) {
      statusText = "Paused: $runType";
      statusColor = Colors.orange;
    } else {
      statusText = "Ready to Run: $runType";
      statusColor = Colors.grey;
    }

    // --- Start: Custom Card Container (ডার্ক ব্যাকগ্রাউন্ড, গোলাকার কোণ) ---
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _kBackgroundColor, // ডার্ক কার্ড ব্যাকগ্রাউন্ড
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. The Status Text (হেডার)
          Text(
            statusText,
            style: TextStyle(
              color: statusColor, // রানিং/পজড স্ট্যাটাস অনুযায়ী রঙ
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12), // হেডার এবং বারের মধ্যে ব্যবধান

          // 2. Custom Progress Bar (পিল-আকৃতি, নির্দিষ্ট উচ্চতা)
          ClipRRect(
            borderRadius: BorderRadius.circular(_kBarHeight / 2), // পিল আকৃতি তৈরি করে
            child: SizedBox(
              height: _kBarHeight,
              child: Stack(
                children: [
                  // Background/Unfilled Track
                  Container(
                    width: double.infinity,
                    color: Colors.white10,
                  ),

                  // The Filled Progress Bar (গতিশীল প্রস্থ)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * currentProgress,
                          height: _kBarHeight,
                          decoration: BoxDecoration(
                            // ফিল্ড রঙ স্ট্যাটাস অনুযায়ী পরিবর্তন হয়
                            color: statusColor, // ডাইনামিক স্ট্যাটাস কালার ব্যবহার করে
                          ),
                        ),
                      );
                    },
                  ),

                  // Percentage Text Overlay (প্রগ্রেস দৃশ্যমান হলে শতাংশ দেখায়)
                  Positioned.fill(
                    child: Center(
                      child: currentProgress > 0.05
                          ? Text(
                        '${(currentProgress * 100).toInt()}%',
                        style: const TextStyle(
                          color: _kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}