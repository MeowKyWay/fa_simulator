import 'package:flutter/material.dart';

abstract interface class Rectable {
  double get top;
  double get left;
  double get bottom;
  double get right;

  Rect get bound {
    return Rect.fromLTRB(left, top, right, bottom);
  }

  bool isContained({
    Offset? topLeft,
    Offset? bottomRight,
    Rect? rect,
  });
}
