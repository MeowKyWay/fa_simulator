import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final Offset start;
  Offset? center;
  final Offset end;

  final double startOffset;
  final double endOffset;

  DashLinePainter({
    required this.start,
    this.center,
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

    center = center ?? (start + end) / 2;

    double startAngle = (start - center!).direction;
    double centerAngle = (center! - end).direction;

    // Define the start and end points of the line
    Offset s = calculateNewPoint(start, startOffset, startAngle);
    Offset e = calculateNewPoint(end, endOffset, centerAngle + pi);

    // Dashed line properties
    double dashLength = 2.5; // Length of each dash
    double gapLength = 2.5; // Gap between dashes

    // Calculate the distance between start and center
    double firstHalfDistance = (center! - s).distance;
    // Calculate the distance between center and end
    double secondHalfDistance = (e - center!).distance;

    // Calculate the direction vector for the line
    Offset firstHalfDirection = (center! - s) / firstHalfDistance;
    Offset secondHalfDirection = (e - center!) / secondHalfDistance;

    // Draw the dashed line
    double currentDistance = 0;
    while (currentDistance < firstHalfDistance) {
      // Calculate the start and end of the current dash
      Offset dashStart = s + firstHalfDirection * currentDistance;
      Offset dashEnd = s +
          firstHalfDirection *
              min(currentDistance + dashLength, firstHalfDistance);

      // Draw the current dash
      canvas.drawLine(dashStart, dashEnd, paint);

      // Move to the next dash position
      currentDistance += dashLength + gapLength;
    }
    currentDistance = 0;
    while (currentDistance < secondHalfDistance) {
      // Calculate the start and end of the current dash
      Offset dashStart = center! + secondHalfDirection * currentDistance;
      Offset dashEnd = center! +
          secondHalfDirection *
              min(currentDistance + dashLength, secondHalfDistance);

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
        oldDelegate.center != center ||
        oldDelegate.end != end ||
        oldDelegate.startOffset != startOffset ||
        oldDelegate.endOffset != endOffset;
  }
}
