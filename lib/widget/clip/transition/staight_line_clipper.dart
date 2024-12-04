import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class StaightLineClipper extends CustomClipper<Path> {
  final Offset start;
  final Offset end;
  final double startOffset;
  final double endOffset;
  final double width;

  StaightLineClipper({
    required this.start,
    required this.end,
    this.startOffset = 0,
    this.endOffset = 0,
    this.width = 10,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    double startAngle = (start - end).direction;

    // Calculate the direction (angle) between the start and end
    Offset adjustedStart = _adjustedStart();
    Offset adjustedEnd = _adjustedEnd();

    Offset point1 =
        _newPoint(adjustedStart, startAngle + pi / 2, width / 2);
    Offset point2 =
        _newPoint(adjustedStart, startAngle - pi / 2, width / 2);
    Offset point3 =
        _newPoint(adjustedEnd, startAngle - pi / 2, width / 2);
    Offset point4 =
        _newPoint(adjustedEnd, startAngle + pi / 2, width / 2);

    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point3.dx, point3.dy);
    path.lineTo(point4.dx, point4.dy);
    path.lineTo(point1.dx, point1.dy);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(StaightLineClipper oldClipper) {
    return oldClipper.start != start || oldClipper.end != end;
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

  Offset _newPoint(Offset point, double angle, double distance) {
    return Offset(
      point.dx + cos(angle) * distance,
      point.dy + sin(angle) * distance,
    );
  }
}
