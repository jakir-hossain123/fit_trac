import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/auth_button.dart';
import '../utils/custom_text_field.dart';
import '../../utils/app_theme.dart';
import '../../routes.dart';
import '../../utils/app_assets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});


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
                const SizedBox(height: 20),


                _buildImageSection(),
                const SizedBox(height: 30),

                // Email Field
                const CustomTextField(
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password Field
                const CustomTextField(
                  labelText: "Password",
                  obscureText: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.white54),
                ),
                const SizedBox(height: 24),

                // Sign In Button
                AuthButton(
                  text: "Sign In",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                  },
                ),
                const SizedBox(height: 20),

                _buildSocialAuthButtons(),
                const SizedBox(height: 20),

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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image 1
          Expanded(child: Image.asset(AppAssets.authImage1, height: 130, fit: BoxFit.cover)),
          const SizedBox(width: 4),
          // Image 2
          Expanded(child: Image.asset(AppAssets.authImage2, height: 130, fit: BoxFit.cover)),
          const SizedBox(width: 4),
          // Image 3
          Expanded(child: Image.asset(AppAssets.authImage3, height: 130, fit: BoxFit.cover)),
        ],
      ),
    );
  }

  Widget _buildSocialAuthButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {},
            // Google Icon
            icon: Image.asset(AppAssets.googleIcon, height: 22),
            label: const Text("Sign in with Google", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0x161B1F),
              side: const BorderSide(color: Color(0x20262B), width: 1),
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
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.facebook, size: 20, color: Color(0xFF1877F2)),
            label: const Text("Sign in with Facebook", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0x161B1F),
              side: const BorderSide(color: Color(0x161B1F), width: 1),
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