import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/cloneable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/rectable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum DiagramTypeEnum {
  state,
  transition,
}

abstract class DiagramType<T extends DiagramType<T>>
    implements Comparable<T>, Jsonable, Rectable, Cloneable<T> {
  final String id;
  final DateTime createdAt = DateTime.now();
  String label;

  DiagramType({
    String? id,
    required this.label,
  }) : id = id ?? Uuid().v4();

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

  bool get hasFocus => FocusProvider().hasFocus(id);
}
