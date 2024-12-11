import 'package:flutter/material.dart';

class RectClipper extends CustomClipper<Rect> {
  final Offset topLeft;
  final Offset bottomRight;

  const RectClipper({
    required this.topLeft,
    required this.bottomRight,
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(topLeft, bottomRight);
  }

  @override
  bool shouldReclip(RectClipper oldClipper) {
    return oldClipper.topLeft != topLeft ||
        oldClipper.bottomRight != bottomRight;
  }
}
