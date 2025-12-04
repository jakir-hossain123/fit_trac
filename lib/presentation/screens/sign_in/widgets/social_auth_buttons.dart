import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/app_assets.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
            },
            icon: Image.asset(AppAssets.googleIcon, height: 22),
            label: const Text(
              "Sign in with Google",
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF161B1F),
              side: const BorderSide(color: Color(0xFF262B2F), width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 18),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
            },
            icon: const FaIcon(FontAwesomeIcons.facebook, size: 20, color: Color(0xFF1877F2)),
            label: const Text(
              "Sign in with Facebook",
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF161B1F),
              side: const BorderSide(color: Color(0xFF161B1F), width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 18),
            ),
          ),
        ),
      ],
    );
  }
}