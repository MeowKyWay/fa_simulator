import 'package:flutter/material.dart';

class RingClipper extends CustomClipper<Path> {

  final double innerRadius;
  final double outerRadius;

  const RingClipper({
    required this.innerRadius,
    required this.outerRadius,
  });

  @override
  Path getClip(Size size) {

    Path path = Path();
    path.addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: outerRadius));
    path.addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: innerRadius));
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}