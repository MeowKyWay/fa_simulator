import 'dart:math';

import 'package:flutter/material.dart';

class TransitionPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  TransitionPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for the line
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw the line
    canvas.drawLine(start, end, paint);

    // Calculate the arrowhead points
    final arrowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const arrowSize = 10;
    final angle = atan2(end.dy - start.dy, end.dx - start.dx);

    // Points for the arrowhead
    final arrowPoint1 = Offset(
      end.dx - arrowSize * cos(angle - pi / 6),
      end.dy - arrowSize * sin(angle - pi / 6),
    );
    final arrowPoint2 = Offset(
      end.dx - arrowSize * cos(angle + pi / 6),
      end.dy - arrowSize * sin(angle + pi / 6),
    );

    // Draw the arrowhead as a filled triangle
    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();

    canvas.drawPath(path, arrowPaint);
  }

  @override
  @override
  bool shouldRepaint(covariant TransitionPainter oldDelegate) {
    // Repaint if start or end positions change
    return start != oldDelegate.start || end != oldDelegate.end;
  }
}