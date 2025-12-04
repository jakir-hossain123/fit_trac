import 'package:flutter/material.dart';

const double _RADIUS = 12.0;
const double _CUT = 20.0;

// LeftImageClipper
class LeftImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    path.lineTo(size.width - _CUT, 0);
    path.quadraticBezierTo(size.width, 0, size.width, _CUT);

    path.lineTo(size.width, size.height - _RADIUS);

    path.quadraticBezierTo(size.width, size.height, size.width - _RADIUS, size.height);

    path.lineTo(_CUT, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - _CUT);

    path.lineTo(0, _RADIUS);

    path.quadraticBezierTo(0, 0, _RADIUS, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

//  CenterImageClipper
class CenterImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    path.quadraticBezierTo(0, 0, 0, _RADIUS);

    path.lineTo(0, size.height - _CUT);

    path.quadraticBezierTo(0, size.height, _CUT, size.height);

    path.lineTo(size.width - _RADIUS, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - _RADIUS);

    path.lineTo(size.width, _CUT);

    path.quadraticBezierTo(size.width, 0, size.width - _CUT, 0);

    path.lineTo(_RADIUS, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

//  RightImageClipper
class RightImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(_RADIUS, 0);

    path.quadraticBezierTo(0, 0, 0, _RADIUS);

    path.lineTo(0, size.height - _CUT);

    path.quadraticBezierTo(0, size.height, _CUT, size.height);

    path.lineTo(size.width - _RADIUS, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - _RADIUS);

    path.lineTo(size.width, _CUT);

    path.quadraticBezierTo(size.width, 0, size.width - _CUT, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


