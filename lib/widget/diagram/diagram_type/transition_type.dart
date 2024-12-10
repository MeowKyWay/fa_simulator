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

  bool isCurved;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceStateId,
    this.destinationStateId,
    this.sourcePosition,
    this.destinationPosition,
    this.isCurved = false,
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

  Path get path {
    Offset start = startButtonPosition;
    Offset end = endButtonPosition;
    if (isCurved && sourceState != null && destinationState != null) {
      // Calculate the center of the control points
      Offset controlPoint = this.controlPoint;

      return Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);
    }

    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(start.dx, start.dy)
      ..close();
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
    if (isCurved && sourceState != null && destinationState != null) {
      return calculateNewPoint(
        sourceState!.position,
        stateSize / 2,
        startAngle + pi - (pi / 12),
      );
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
    if (isCurved && sourceState != null && destinationState != null) {
      return calculateNewPoint(
        destinationState!.position,
        stateSize / 2,
        endAngle + pi + (pi / 12),
      );
    }
    return calculateNewPoint(
      destinationState!.position,
      stateSize / 2,
      endAngle + pi,
    );
  }

  double get startAngle {
    return (startPosition - endPosition).direction;
  }

  double get endAngle {
    return (endPosition - startPosition).direction;
  }

  Offset get controlPoint {
    return calculateNewPoint(
        (startPosition + endPosition) / 2, stateSize / 2, startAngle + pi / 2);
  }

  Offset get circleCenter {
    try {
      return findCircumcenter(
          startButtonPosition, controlPoint, endButtonPosition)!;
    } catch (e) {
      throw Exception("Cannot find circumcenter of transition $id");
    }
  }

  double get arrowAngle {
    if (!isCurved) {
      return endAngle + pi;
    }
    // Calculate the tangent vector at the end of the curve
    double dx = endButtonPosition.dx - controlPoint.dx;
    double dy = endButtonPosition.dy - controlPoint.dy;

    // Calculate the angle using atan2 (returns the angle in radians)
    return atan2(dy, dx) + pi;
  }

  void resetSourceState() {
    if (sourcePosition == null) {
      throw Exception(
          "Source position must be provided before reseting the source state");
    }
    sourceStateId = null;
    isCurved = false;
  }

  void resetDestinationState() {
    if (destinationPosition == null) {
      throw Exception(
          "Destination position must be provided before reseting the destination state");
    }
    destinationStateId = null;
    isCurved = false;
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

  void updateIsCurved(bool value) {
    /*Call this before detach the transition with false value*/
    /*Call this after attach the transition with true value*/
    if (sourceStateId == null || destinationStateId == null) {
      return;
    }
    try {
      TransitionType transition = DiagramList()
          .getTransitionByState(destinationStateId!, sourceStateId!)!;
      transition.isCurved = value;
      isCurved = value;
    } catch (e) {
      return;
    }
  }

  @override
  double get top => min(startButtonPosition.dy, endButtonPosition.dy);
  @override
  double get left => min(startButtonPosition.dx, endButtonPosition.dx);
  @override
  double get bottom => max(startButtonPosition.dy, endButtonPosition.dy);
  @override
  double get right => max(startButtonPosition.dx, endButtonPosition.dx);

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
