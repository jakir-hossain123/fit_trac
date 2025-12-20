import 'package:flutter/material.dart';

class WorkoutStats extends StatelessWidget {
  const WorkoutStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tag("4", "/12 rep"),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("×", style: TextStyle(color: Colors.white54, fontSize: 20))
        ),
        _tag("1", "/3 set"),
      ],
    );
  }

  Widget _tag(String bold, String light) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
        color: const Color(0xFF20262B),
        borderRadius: BorderRadius.circular(20)
    ),
    child: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: bold,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: light,
            style: const TextStyle(color: Colors.white54, fontSize: 14)),
      ]),
    ),
  );
}