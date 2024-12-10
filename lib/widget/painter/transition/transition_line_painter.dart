import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

class TransitionLinePainter extends CustomPainter {
  final TransitionType transition;

  TransitionLinePainter({
    required this.transition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = transition.path;

    Paint paint = Paint()
      ..color = transitionLineColor
      ..strokeWidth = transitionLineWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TransitionLinePainter oldDelegate) {
    return oldDelegate.transition != transition;
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }
}
