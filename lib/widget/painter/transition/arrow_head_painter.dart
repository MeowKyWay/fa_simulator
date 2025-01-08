import 'dart:math';

import 'package:flutter/material.dart';

class ArrowHeadPainter extends CustomPainter {
  final Offset position;
  final double angle;
  final double arrowSize;
  final double offset;
  final Color color;

  const ArrowHeadPainter({
    required this.position,
    required this.angle,
    this.arrowSize = 10.0,
    this.offset = 0.0,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    Offset adjustedPosition = Offset(
      position.dx + offset * cos(angle),
      position.dy + offset * sin(angle),
    );

    Offset arrowPoint1 = Offset(
      adjustedPosition.dx - arrowSize * cos(angle + pi / 6 + pi),
      adjustedPosition.dy - arrowSize * sin(angle + pi / 6 + pi),
    );
    Offset arrowPoint2 = Offset(
      adjustedPosition.dx - arrowSize * cos(angle - pi / 6 + pi),
      adjustedPosition.dy - arrowSize * sin(angle - pi / 6 + pi),
    );

    path.moveTo(adjustedPosition.dx, adjustedPosition.dy);
    path.lineTo(arrowPoint1.dx, arrowPoint1.dy);
    path.lineTo(arrowPoint2.dx, arrowPoint2.dy);
    path.lineTo(adjustedPosition.dx, adjustedPosition.dy);
    path.close();

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowHeadPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.angle != angle ||
        oldDelegate.arrowSize != arrowSize;
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }
}
