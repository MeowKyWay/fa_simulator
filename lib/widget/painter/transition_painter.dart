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

    // Calculate the direction vector (normalized)
    final direction = (end - start).normalize();

    // Adjust the end position to offset the arrowhead by 50 pixels
    const double arrowOffset = 0;
    final adjustedEnd = end - direction * arrowOffset;

    // Draw the line up to the adjusted end
    canvas.drawLine(start, adjustedEnd, paint);

    // Paint object for the arrowhead
    final arrowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const arrowSize = 10.0;
    final angle = atan2(direction.dy, direction.dx);

    // Points for the arrowhead
    final arrowPoint1 = Offset(
      adjustedEnd.dx - arrowSize * cos(angle - pi / 6),
      adjustedEnd.dy - arrowSize * sin(angle - pi / 6),
    );
    final arrowPoint2 = Offset(
      adjustedEnd.dx - arrowSize * cos(angle + pi / 6),
      adjustedEnd.dy - arrowSize * sin(angle + pi / 6),
    );

    // Draw the arrowhead as a filled triangle
    final path = Path()
      ..moveTo(adjustedEnd.dx, adjustedEnd.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();

    canvas.drawPath(path, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant TransitionPainter oldDelegate) {
    // Repaint if start or end positions change
    return start != oldDelegate.start || end != oldDelegate.end;
  }
}

extension OffsetExtension on Offset {
  /// Normalize the vector (make its magnitude 1)
  Offset normalize() {
    final length = distance;
    return length == 0 ? this : this / length;
  }
}