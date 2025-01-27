import 'dart:math';

import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

extension TransitionPath on TransitionType {
  Path getHitBox(double offset) {
    Offset start = startButtonPosition - Offset(left - 5, top - 5);
    Offset end = endButtonPosition - Offset(left - 5, top - 5);

    Offset point1 = calculateNewPoint(start, offset, startAngle + pi / 2);
    Offset point2 = calculateNewPoint(end, offset, startAngle + pi / 2);

    Offset point3 = calculateNewPoint(start, offset, startAngle - pi / 2);
    Offset point4 = calculateNewPoint(end, offset, startAngle - pi / 2);

    if (loopCenter != null) {
      double radius1 = loopRadius + offset;
      double radius2 = loopRadius - offset;
      Offset center = loopCenter! - Offset(left - 5, top - 5);
      Rect rect1 = Rect.fromCircle(center: center, radius: radius1);
      Rect rect2 = Rect.fromCircle(center: center, radius: radius2);
      Offset p1 = calculateNewPoint(center, radius1, endLineAngle + pi);
      Offset p2 = calculateNewPoint(
          center, radius2, -endLineAngle + pi + 2 * loopAngle);
      Path path = Path();
      path.addArc(
          rect1, endLineAngle + pi, 2 * pi - (endLineAngle - loopAngle) * 2);
      path.lineTo(p2.dx, p2.dy);
      path.arcTo(rect2, -endLineAngle + pi - 2 * loopAngle,
          -(2 * pi - (endLineAngle - loopAngle) * 2), false);
      path.lineTo(p1.dx, p1.dy);
      path.close();
      return path;
    }

    if (isCurved && sourceState != null && destinationState != null) {
      // Calculate the center of the control points
      Offset controlPoint = this.controlPoint - Offset(left - 5, top - 5);
      Offset controlPoint1 =
          calculateNewPoint(controlPoint, offset, startAngle + pi / 2);
      Offset controlPoint2 =
          calculateNewPoint(controlPoint, offset, startAngle - pi / 2);

      Path path = Path();
      path.moveTo(point1.dx, point1.dy);
      path.quadraticBezierTo(
          controlPoint1.dx, controlPoint1.dy, point2.dx, point2.dy);
      path.lineTo(point4.dx, point4.dy);
      path.quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, point3.dx, point3.dy);
      path.lineTo(point1.dx, point1.dy);
      path.close();
      return path;
    }

    Path path = Path();
    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point4.dx, point4.dy);
    path.lineTo(point3.dx, point3.dy);
    path.lineTo(point1.dx, point1.dy);
    path.close();
    return path;
  }

  Path get path {
    Offset start = startButtonPosition;
    Offset end = endButtonPosition;
    if (loopCenter != null) {
      double radius = loopRadius;
      Offset center = loopCenter!;
      Path path = Path();
      Rect rect = Rect.fromCircle(center: center, radius: radius);
      path.addArc(
          rect, endLineAngle + pi, 2 * pi - (endLineAngle - loopAngle) * 2);
      return path;
    }
    if (isCurved && sourceState != null && destinationState != null) {
      // Calculate the center of the control points
      Offset controlPoint = this.controlPoint;

      return Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);
    }

    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
  }
}
