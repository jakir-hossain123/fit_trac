// ফাইল: lib/pages/sign_in/widgets/curved_image_clipper.dart

import 'package:flutter/material.dart';

const double _RADIUS = 12.0;
const double _CUT = 20.0;

// ----------------------------------------------------------------------
// ১. LeftImageClipper
// ----------------------------------------------------------------------
class LeftImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    // উপরের কোণ (Right Edge Curvature)
    path.lineTo(size.width - _CUT, 0);
    path.quadraticBezierTo(size.width, 0, size.width, _CUT);

    // ডান পাশ
    path.lineTo(size.width, size.height - _RADIUS);

    // নিচের ডান কোণ (Round)
    path.quadraticBezierTo(size.width, size.height, size.width - _RADIUS, size.height);

    // নিচের বাম কোণে কাট (Bottom Left Curvature)
    path.lineTo(_CUT, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - _CUT);

    // বাম পাশ
    path.lineTo(0, _RADIUS);

    // উপরের বাম কোণ (Round)
    path.quadraticBezierTo(0, 0, _RADIUS, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ----------------------------------------------------------------------
// ২. CenterImageClipper
// ----------------------------------------------------------------------
class CenterImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    // উপরের বাম কোণ (Round)
    path.quadraticBezierTo(0, 0, 0, _RADIUS);

    // বাম পাশ
    path.lineTo(0, size.height - _CUT);

    // নিচের বাম কোণে কাট (Bottom Left Curvature)
    path.quadraticBezierTo(0, size.height, _CUT, size.height);

    // নিচের ডান কোণ (Round)
    path.lineTo(size.width - _RADIUS, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - _RADIUS);

    // ডান পাশ
    path.lineTo(size.width, _CUT);

    // উপরের ডান কোণে কাট (Top Right Curvature)
    path.quadraticBezierTo(size.width, 0, size.width - _CUT, 0);

    // উপরের বাম কোণ পর্যন্ত
    path.lineTo(_RADIUS, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ----------------------------------------------------------------------
// ৩. RightImageClipper
// ----------------------------------------------------------------------
class RightImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    // উপরের বাম কোণ (Round)
    path.quadraticBezierTo(0, 0, 0, _RADIUS);

    // বাম পাশ
    path.lineTo(0, size.height - _CUT);

    // নিচের বাম কোণে কাট (Bottom Left Curvature)
    path.quadraticBezierTo(0, size.height, _CUT, size.height);

    // নিচের ডান কোণ (Round)
    path.lineTo(size.width - _RADIUS, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - _RADIUS);

    // ডান পাশ
    path.lineTo(size.width, _CUT);

    // উপরের ডান কোণে কাট (Top Right Curvature)
    path.quadraticBezierTo(size.width, 0, size.width - _CUT, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ----------------------------------------------------------------------
// Helper ফাংশন যা index অনুযায়ী সঠিক ক্লিপার দেবে
// ----------------------------------------------------------------------
CustomClipper<Path> _getClipper(int index) {
  if (index == 0) return LeftImageClipper();
  if (index == 1) return CenterImageClipper();
  return RightImageClipper();
}