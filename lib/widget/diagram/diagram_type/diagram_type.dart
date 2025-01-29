import 'package:fa_simulator/widget/diagram/diagram_type/interface/cloneable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/rectable.dart';
import 'package:flutter/material.dart';

enum DiagramTypeEnum {
  state,
  transition,
}

abstract class DiagramType<T extends DiagramType<T>>
    implements Comparable<T>, Jsonable, Rectable, Cloneable<T> {
  final String id;
  bool hasFocus;
  String label;

  DiagramType({
    required this.id,
    required this.label,
    this.hasFocus = false,
  });

  @override
  Rect get bound {
    return Rect.fromLTRB(left, top, right, bottom);
  }

  @override
  bool isContained({
    Offset? topLeft,
    Offset? bottomRight,
    Rect? rect,
  }) {
    assert(
      topLeft != null && bottomRight != null || rect != null,
      'Rectable/isContained: topLeft and bottomRight or rect must be provided',
    );
    double left = rect?.left ?? topLeft!.dx;
    double top = rect?.top ?? topLeft!.dy;
    double right = rect?.right ?? bottomRight!.dx;
    double bottom = rect?.bottom ?? bottomRight!.dy;

    return this.left >= left &&
        this.top >= top &&
        this.right <= right &&
        this.bottom <= bottom;
  }
}
