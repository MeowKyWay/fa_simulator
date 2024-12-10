import 'dart:math';

import 'package:flutter/material.dart';

Offset calculateNewPoint(Offset startPoint, double distance, double angle) {
  // Calculate the new x and y coordinates
  double x = startPoint.dx + distance * cos(angle);
  double y = startPoint.dy + distance * sin(angle);

  return Offset(x, y);
}

Offset? findCircumcenter(Offset a, Offset b, Offset c) {
  double d =
      2 * (a.dx * (b.dy - c.dy) + b.dx * (c.dy - a.dy) + c.dx * (a.dy - b.dy));

  if (d == 0) {
    // The points are collinear; no unique circumcenter exists.
    return null;
  }

  double aSquared = a.dx * a.dx + a.dy * a.dy;
  double bSquared = b.dx * b.dx + b.dy * b.dy;
  double cSquared = c.dx * c.dx + c.dy * c.dy;

  double centerX = (aSquared * (b.dy - c.dy) +
          bSquared * (c.dy - a.dy) +
          cSquared * (a.dy - b.dy)) /
      d;
  double centerY = (aSquared * (c.dx - b.dx) +
          bSquared * (a.dx - c.dx) +
          cSquared * (b.dx - a.dx)) /
      d;

  return Offset(centerX, centerY);
}
