import 'package:flutter/material.dart';

class ItemDetail {
  String id;
  String? label;

  ItemDetail({
    required this.id,
    this.label,
  });
}

class StateDetail {
  String id;
  String? label;
  Offset? position;
  bool? isInitial;
  bool? isFinal;
  double? initialArrowAngle;

  StateDetail({
    required this.id,
    this.label,
    this.position,
    this.isInitial,
    this.isFinal,
    this.initialArrowAngle,
  });
}

class TransitionDetail {
  String id;
  String? label;
  Offset? sourcePosition;
  Offset? destinationPosition;
  String? sourceStateId;
  String? destinationStateId;
  double? loopAngle;
  bool? isCurved;

  TransitionDetail({
    required this.id,
    this.label,
    this.sourcePosition,
    this.destinationPosition,
    this.sourceStateId,
    this.destinationStateId,
    this.loopAngle,
    this.isCurved,
  })  : assert(!(sourcePosition != null && sourceStateId != null)),
        assert(!(destinationPosition != null && destinationStateId != null));
}
