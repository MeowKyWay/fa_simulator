import 'package:flutter/material.dart';
import 'dart:math';

class StaightLineClipper extends CustomClipper<Path> {
  final Offset start;
  final Offset? center;
  final Offset end;
  final double startOffset;
  final double endOffset;
  final double width;

  StaightLineClipper({
    required this.start,
    this.center,
    required this.end,
    this.startOffset = 0,
    this.endOffset = 0,
    this.width = 10,
  });

  @override
  @override
  Path getClip(Size size) {
    Path path = Path();

    double startAngle = ((start - (center ?? end)).direction) % (2 * pi);
    double endAngle = (((center ?? start) - end).direction) % (2 * pi);
    double? centerAngle;

    // Calculate the direction (angle) between the start and end
    Offset s = _adjustedStart();
    Offset e = _adjustedEnd();

    Offset point1 = _newPoint(s, startAngle + pi / 2, width / 2);
    Offset point2 = _newPoint(s, startAngle - pi / 2, width / 2);
    Offset point3 = _newPoint(e, endAngle - pi / 2, width / 2);
    Offset point4 = _newPoint(e, endAngle + pi / 2, width / 2);

    Offset? point5; // for center point
    Offset? point6; // for center point

    if (center != null) {
      centerAngle = ((startAngle + endAngle) / 2) % (2 * pi);
      // Adjust inner and outer widths based on distances

      point5 = _newPoint(center!, centerAngle - pi / 2, width / 2);
      point6 = _newPoint(center!, centerAngle + pi / 2, width / 2);
    }

    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    if (center != null) {
      path.lineTo(point5!.dx, point5.dy);
    }
    path.lineTo(point3.dx, point3.dy);
    path.lineTo(point4.dx, point4.dy);
    if (center != null) {
      path.lineTo(point6!.dx, point6.dy);
    }
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
