import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class TransitionType extends DiagramType {
  String? sourceStateId;
  String? destinationStateId;

  Offset? sourcePosition;
  Offset? destinationPosition;

  Offset? centerPivot;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceStateId,
    this.destinationStateId,
    this.sourcePosition,
    this.destinationPosition,
    this.centerPivot,
  }) : super() {
    // Validation logic moved to constructor body
    if ((sourcePosition ?? sourceStateId) == null) {
      throw ArgumentError(
          "Either sourcePosition or sourceState must be provided");
    }

    if ((destinationPosition ?? destinationStateId) == null) {
      throw ArgumentError(
          "Either destinationPosition or destinationState must be provided");
    }
  }

  StateType? get sourceState {
    if (sourceStateId == null) {
      return null;
    }
    return DiagramList().state(sourceStateId!);
  }

  StateType? get destinationState {
    if (destinationStateId == null) {
      return null;
    }
    return DiagramList().state(destinationStateId!);
  }

  Offset get startPosition {
    // Does not have source state
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    return sourceState!.position;
  }

  Offset get endPosition {
    // Does not have destination state
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    return destinationState!.position;
  }

  Offset get startButtonPosition {
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    return calculateNewPoint(
      sourceState!.position,
      stateSize / 2,
      startAngle + pi,
    );
  }

  Offset get endButtonPosition {
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    return calculateNewPoint(
      destinationState!.position,
      stateSize / 2,
      endAngle + pi,
    );
  }

  Offset get centerPosition {
    if (centerPivot != null) {
      return centerPivot!;
    }
    return (startButtonPosition + endButtonPosition) / 2;
  }

  double get startAngle {
    return (startPosition - (centerPivot ?? endPosition)).direction;
  }

  double get endAngle {
    return (endPosition - (centerPivot ?? startPosition)).direction;
  }

  void resetSourceState() {
    if (sourcePosition == null) {
      throw Exception(
          "Source position must be provided before reseting the source state");
    }
    sourceStateId = null;
  }

  void resetDestinationState() {
    if (destinationPosition == null) {
      throw Exception(
          "Destination position must be provided before reseting the destination state");
    }
    destinationStateId = null;
  }

  void resetSourcePosition() {
    if (sourceState == null) {
      throw Exception(
          "Source state must be provided before reseting the source position");
    }
    sourcePosition = null;
  }

  void resetDestinationPosition() {
    if (destinationState == null) {
      throw Exception(
          "Destination state must be provided before reseting the destination position");
    }
    destinationPosition = null;
  }

  @override
  double get top =>
      min(min(startButtonPosition.dy, endButtonPosition.dy), centerPosition.dy);
  @override
  double get left =>
      min(min(startButtonPosition.dx, endButtonPosition.dx), centerPosition.dx);
  @override
  double get bottom =>
      max(max(startButtonPosition.dy, endButtonPosition.dy), centerPosition.dy);
  @override
  double get right =>
      max(max(startButtonPosition.dx, endButtonPosition.dx), centerPosition.dx);

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'sourceState': sourceState,
      'destinationState': destinationState,
      'sourcePosition': sourcePosition,
      'destinationPosition': destinationPosition,
    }.toString();
  }

  @override
  bool isContained(Offset topLeft, Offset bottomRight) {
    return topLeft.dx < left &&
        topLeft.dy < top &&
        bottomRight.dx > right &&
        bottomRight.dy > bottom;
  }
}
