import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class DiagramType {
  final String id;
  bool hasFocus;
  String label;

  DiagramType({
    required this.id,
    required this.label,
    this.hasFocus = false,
  });
}

class StateType extends DiagramType {
  Offset position;
  bool isDragging;
  bool isRenaming;
  bool isHovering;

  StateType({
    required this.position,
    required super.id,
    required super.label,
    super.hasFocus,
    this.isDragging = false,
    this.isRenaming = false,
    this.isHovering = false,
  });
}

class TransitionType extends DiagramType {
  final StateType? sourceState;
  final StateType? destinationState;
  final bool? sourceStateCentered;
  final bool? destinationStateCentered;

  final double? sourceStateAngle;
  final double? destinationStateAngle;

  final Offset? sourcePosition;
  final Offset? destinationPosition;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceState,
    this.destinationState,
    this.sourceStateCentered,
    this.destinationStateCentered,
    this.sourceStateAngle,
    this.destinationStateAngle,
    this.sourcePosition,
    this.destinationPosition,
  }) : super() {
    // Validation logic moved to constructor body
    if ((sourcePosition ?? sourceState) == null) {
      throw ArgumentError(
          "Either sourcePosition or sourceState must be provided");
    }

    if ((destinationPosition ?? destinationState) == null) {
      throw ArgumentError(
          "Either destinationPosition or destinationState must be provided");
    }

    if (sourceState == destinationState) {
      throw ArgumentError("Source and destination states must be different");
    }

    if (((sourceStateCentered ?? false) ? false : sourceStateAngle == null)) {
      if (sourceState != null) {
        throw ArgumentError("Source state information must be provided");
      }
    }

    if (((destinationStateCentered ?? false)
        ? false
        : destinationStateAngle == null)) {
      if (destinationState != null) {
        throw ArgumentError("Destination state information must be provided");
      }
    }
  }

  Offset get startPosition {
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    if (sourceStateCentered!) {
      return sourceState!.position;
    }
    return calculateNewPoint(
      sourceState!.position,
      stateSize / 2,
      sourceStateAngle!,
    );
  }

  Offset get endPosition {
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    if (destinationStateCentered!) {
      return destinationState!.position;
    }
    return calculateNewPoint(
      destinationState!.position,
      stateSize / 2,
      destinationStateAngle!,
    );
  }
}
