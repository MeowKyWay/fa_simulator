import 'dart:math';

import 'package:flutter/material.dart';

Offset calculateNewPoint(Offset startPoint, double distance, double angle) {

  // Calculate the new x and y coordinates
  double x = startPoint.dx + distance * cos(angle);
  double y = startPoint.dy + distance * sin(angle);

  return Offset(x, y);
}