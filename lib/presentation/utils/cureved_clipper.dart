import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, 30);
    path.quadraticBezierTo(
      size.width * 0.5,
      -20,
      size.width,
      30,
    );

    path.lineTo(size.width, size.height - 30);


    path.quadraticBezierTo(
      size.width * 0.5,
      size.height + 20,
      0,
      size.height - 30,
    );


    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}