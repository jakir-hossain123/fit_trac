import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fit_trac/models/app_user.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_theme.dart';
import '../../../routes.dart';
import '../../sign_in-sign_up-utils/auth_button.dart';
import '../../sign_in-sign_up-utils/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 1. Controllers and State
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // Date of Birth Controller
  final _dobController = TextEditingController();

  DateTime? _selectedDateOfBirth;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // 2. Date Picker Logic
  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.primaryTeal,
              onPrimary: Colors.white,
              surface: AppTheme.primaryDarkColor,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppTheme.primaryDarkColor,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
        _dobController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  // 3. Firebase Sign Up Logic

  // 4. Build Method
  @override
  Widget build(BuildContext context) {
    final dobLabel = _selectedDateOfBirth == null
        ? "Date of Birth"
        : DateFormat('dd MMM yyyy').format(_selectedDateOfBirth!);

    return Scaffold(
      backgroundColor: AppTheme.primaryDarkColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo
                  SvgPicture.asset(AppAssets.logo, height: 70),
                  const SizedBox(height: 25),

                  // Input Fields
                  CustomTextField(
                    labelText: "First Name",
                    controller: _firstNameController,
                    validator: (v) => v!.isEmpty ? 'Enter your first name' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Last Name",
                    controller: _lastNameController,
                    validator: (v) => v!.isEmpty ? 'Enter your last name' : null,
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth Field
                  GestureDetector(
                    onTap: () => _selectDateOfBirth(context),
                    child: CustomTextField(
                      labelText: dobLabel,
                      enabled: false,
                      controller: _dobController,
                      suffixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.white54),
                      validator: (v) => v!.isEmpty ? 'Select your date of birth' : null,
                    ),
                  ),

                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (v) => v!.isEmpty || !v.contains('@') ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Password",
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
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
                    validator: (v) => v!.length < 6 ? 'Password must be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Confirm Password",
                    obscureText: !_isPasswordVisible,
                    controller: _confirmPasswordController,
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
                    validator: (v) {
                      if (v!.isEmpty) return 'Confirm password is required';
                      if (v != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  // Sign Up Button

                  const SizedBox(height: 20),

                  // Login Row'
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}