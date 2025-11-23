import 'package:flutter/material.dart';

class WalkActivityCard extends StatelessWidget {
  const WalkActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF122027),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.favorite, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text(
                "Today's Activity",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.8,
              minHeight: 10,
              backgroundColor: Colors.white10,
              valueColor:
              const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("1.6 km", style: TextStyle(color: Colors.white70)),
              Text("1389 steps",
                  style: TextStyle(color: Colors.white70)),
              Text("5 min", style: TextStyle(color: Colors.white70)),
              Text("120 kcal", style: TextStyle(color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }
}