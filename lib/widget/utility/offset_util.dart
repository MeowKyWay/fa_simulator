import 'dart:math';

import 'package:flutter/material.dart';

double calculateAngle(Offset startPoint, Offset endPoint) {
  return (endPoint - startPoint).direction;
}

Offset calculateNewPoint(Offset startPoint, double distance, double angle) {
  // Convert the angle to radians
  angle = angle * (pi / 180);

  // Calculate the new x and y coordinates
  double x = startPoint.dx + distance * cos(angle);
  double y = startPoint.dy + distance * sin(angle);

  return Offset(x, y);
}