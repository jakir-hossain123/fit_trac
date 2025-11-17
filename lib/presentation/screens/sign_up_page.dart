import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/auth_button.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_theme.dart';
import '../../routes.dart';
import '../utils/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  void _handleSignUp(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo
                SvgPicture.asset(AppAssets.logo, height: 70),
                const SizedBox(height: 25),

                // Input Fields
                const CustomTextField(labelText: "First Name"),
                const SizedBox(height: 16),
                const CustomTextField(labelText: "Last Name"),
                const SizedBox(height: 16),
                const CustomTextField(
                  labelText: "Date of Birth",
                  suffixIcon: Icon(Icons.calendar_today_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  labelText: "Password",
                  obscureText: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  labelText: "Confirm Password",
                  obscureText: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 25),

                // Sign Up Button
                AuthButton(
                  text: "Sign Up",
                  onPressed: () => _handleSignUp(context),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have any account? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        // Navigates back to SignInPage (since it's usually the previous route)
                        Navigator.pop(context);
                      },
                      child: const Text("Login", style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}