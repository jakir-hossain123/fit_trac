import 'package:fit_trac/presentation/screens/sign_in/widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_theme.dart';
import '../../../routes.dart';
import '../../../utils/app_assets.dart';
import '../../sign_in-sign_up-utils/auth_button.dart';
import '../../sign_in-sign_up-utils/custom_text_field.dart';
import 'widgets/social_auth_buttons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Local state for interactive elements
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                SvgPicture.asset(AppAssets.logo, height: 70),

                const SizedBox(height: 20),

                // THE IMAGE CAROUSEL
                const ImageCarousel(),

                const SizedBox(height: 30),

                // Email Field
                CustomTextField(
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 16),

                // Password Field
                CustomTextField(
                  labelText: "Password",
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,
                        color: Colors.white54
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Sign In Button
                AuthButton(
                  text: "Sign In",
                  isLoading: _isLoading,
                  onPressed: _handleSignIn,
                ),

                const SizedBox(height: 20),

                // Social Buttons
                const SocialAuthButtons(),

                const SizedBox(height: 20),

                // Register Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                      child: const Text("Register", style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}