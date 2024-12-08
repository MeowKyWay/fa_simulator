import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

class StaightLinePainter extends CustomPainter {
  final Offset start;
  final Offset? center;
  final Offset end;

  final double startOffset;
  final double endOffset;

  StaightLinePainter({
    required this.start,
    this.center,
    required this.end,
    this.startOffset = 0,
    this.endOffset = 0,
  });

  final Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    double width = transitionLineWidth;

    Offset adjustedStart = _adjustedStart();
    Offset adjustedEnd = _adjustedEnd();

    _path.moveTo(adjustedStart.dx, adjustedStart.dy);
    if (center != null) {
      _path.lineTo(center!.dx, center!.dy);
    }
    // _path.lineTo(start.dx+10, start.dy+10);
    _path.lineTo(adjustedEnd.dx, adjustedEnd.dy);
    if (center != null) {
      _path.lineTo(center!.dx, center!.dy);
    }
    _path.lineTo(adjustedStart.dx, adjustedStart.dy);
    _path.close();

    Paint paint = Paint()
      ..color = transitionLineColor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(covariant StaightLinePainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.startOffset != startOffset ||
        oldDelegate.endOffset != endOffset;
  }

  // @override
  // bool hitTest(Offset position) {
  //   double hypotenuse = (_adjustedStart() - position).distance.abs();
  //   double angleStart = (_adjustedStart() - position).direction -
  //       (_adjustedStart() - _adjustedEnd()).direction;
  //   double angleEnd = (_adjustedEnd() - position).direction -
  //       (_adjustedEnd() - _adjustedStart()).direction;

  //   double diffStart = ((angleStart + pi) % (2 * pi) - pi).abs();
  //   double diffEnd = ((angleEnd + pi) % (2 * pi) - pi).abs();

  //   double distance = (hypotenuse * sin(angleStart)).abs();
  //   return diffStart <= pi / 2 && diffEnd <= pi / 2 ? distance < 10 : false;
  // }

  @override
  bool hitTest(Offset position) {
    return false;
  }

  Offset _adjustedStart() {
    double angle = (start - end).direction;
    return -Offset(
          cos(angle) * startOffset,
          sin(angle) * startOffset,
        ) +
        start;
  }

  Offset _adjustedEnd() {
    double angle = (start - end).direction;
    return -Offset(
          cos(angle + pi) * endOffset,
          sin(angle + pi) * endOffset,
        ) +
        end;
  }
  
}
