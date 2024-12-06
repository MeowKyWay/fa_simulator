import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  final double startOffset;
  final double endOffset;

  DashLinePainter({
    required this.start,
    required this.end,
    this.startOffset = 0,
    this.endOffset = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = transitionLineWidth
      ..style = PaintingStyle.stroke;

    double angle = calculateAngle(start, end);

    // Define the start and end points of the line
    Offset adjustedStart = calculateNewPoint(start, startOffset, angle);
    Offset adjustedEnd = calculateNewPoint(end, endOffset, angle + pi);

    // Dashed line properties
    double dashLength = 2.5; // Length of each dash
    double gapLength = 2.5; // Gap between dashes

    // Calculate the distance between start and end
    double totalDistance = (adjustedEnd - adjustedStart).distance;

    // Calculate the direction vector for the line
    Offset direction = (adjustedEnd - adjustedStart) / totalDistance;

    // Draw the dashed line
    double currentDistance = 0;
    while (currentDistance < totalDistance) {
      // Calculate the start and end of the current dash
      Offset dashStart = adjustedStart + direction * currentDistance;
      Offset dashEnd = adjustedStart +
          direction * min(currentDistance + dashLength, totalDistance);

      // Draw the current dash
      canvas.drawLine(dashStart, dashEnd, paint);

      // Move to the next dash position
      currentDistance += dashLength + gapLength;
    }
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }

  @override
  bool shouldRepaint(covariant DashLinePainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.startOffset != startOffset ||
        oldDelegate.endOffset != endOffset;
  }
}
