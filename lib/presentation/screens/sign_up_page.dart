import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/auth_button.dart';
import '../utils/core/app_theme.dart';
import '../utils/core/routes.dart';
import '../utils/custom_text_field.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleSignUp() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

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
                SvgPicture.asset("assets/images/Frame 1.svg", height: 70),
                const SizedBox(height: 25),

                CustomTextField(labelText: "First Name", controller: _firstNameController),
                const SizedBox(height: 16),
                CustomTextField(labelText: "Last Name", controller: _lastNameController),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: "Date of Birth",
                  controller: _dobController,
                  suffixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: "Confirm Password",
                  controller: _confirmPasswordController,
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 25),

                AuthButton(
                  text: "Sign Up",
                  onPressed: _handleSignUp,
                ),
                const SizedBox(height: 20),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have any account? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
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