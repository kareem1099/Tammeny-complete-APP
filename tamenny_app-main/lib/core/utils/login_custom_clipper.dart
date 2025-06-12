import 'package:flutter/material.dart';

class CustomLogoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    var h = size.height;
    var w = size.width;
    path.lineTo(0, h * 0.7);
    path.quadraticBezierTo(w * 0.5, h + 40, w, h * 0.7);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
