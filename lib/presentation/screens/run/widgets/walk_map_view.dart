import 'package:flutter/material.dart';

class WalkMapView extends StatelessWidget {
  const WalkMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/Map.png',
          fit: BoxFit.cover,

        ),
      ),
    );
  }
}