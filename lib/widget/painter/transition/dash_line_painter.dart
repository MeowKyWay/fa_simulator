import 'dart:ui';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';

class DashLinePainter extends CustomPainter {
  TransitionType? transition;
  Offset? start;
  Offset? end;
  Color color;

  DashLinePainter({
    this.transition,
    this.start,
    this.end,
    required this.color,
  }) {
    if (transition == null && (start == null || end == null)) {
      throw Exception("Either transition or start and end must be provided");
    }
  }

  Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    if (transition != null) {
      _path = transition!.path;
    } else {
      _path = Path()
        ..moveTo(start!.dx, start!.dy)
        ..lineTo(end!.dx, end!.dy);
    }

    Path dashPath = Path();

    double dashWidth = 5;
    double dashSpace = 2.5;
    double distance = 0.0;

    for (PathMetric pathMetric in _path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }

  @override
  bool shouldRepaint(covariant DashLinePainter oldDelegate) {
    try {
      if (transition != null) {
        return transition != oldDelegate.transition;
      }
      return start != oldDelegate.start || end != oldDelegate.end;
    } catch (e) {
      return true;
    }
  }
}
