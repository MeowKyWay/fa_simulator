import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
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

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'position': position,
      'isDragging': isDragging,
      'isRenaming': isRenaming,
      'isHovering': isHovering,
    }.toString();
  }
}

class TransitionType extends DiagramType {
  String? sourceStateId;
  String? destinationStateId;
  bool? sourceStateCentered;
  bool? destinationStateCentered;

  double? sourceStateAngle;
  double? destinationStateAngle;

  Offset? sourcePosition;
  Offset? destinationPosition;

  Offset? centerPivot;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceStateId,
    this.destinationStateId,
    this.sourceStateCentered,
    this.destinationStateCentered,
    this.sourceStateAngle,
    this.destinationStateAngle,
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

    if (((sourceStateCentered ?? false) ? false : sourceStateAngle == null)) {
      if (sourceStateId != null) {
        throw ArgumentError("Source state information must be provided");
      }
    }

    if (((destinationStateCentered ?? false)
        ? false
        : destinationStateAngle == null)) {
      if (destinationStateId != null) {
        throw ArgumentError("Destination state information must be provided");
      }
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
    // Source state is centered
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
    // Does not have destination state
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    // Destination state is centered
    if (destinationStateCentered!) {
      return destinationState!.position;
    }
    return calculateNewPoint(
      destinationState!.position,
      stateSize / 2,
      destinationStateAngle!,
    );
  }

  Offset get startButtonPosition {
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    if (sourceStateCentered!) {
      return calculateNewPoint(sourceState!.position, stateSize / 2, endAngle);
    }
    return startPosition;
  }

  Offset get endButtonPosition {
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    if (destinationStateCentered!) {
      return calculateNewPoint(
          destinationState!.position, stateSize / 2, startAngle);
    }
    return endPosition;
  }

  Offset get centerPosition {
    if (centerPivot != null) {
      return centerPivot!;
    }
    return (startButtonPosition + endButtonPosition) / 2;
  }

  double get startAngle {
    return (startPosition - endPosition).direction;
  }

  double get endAngle {
    return (endPosition - startPosition).direction;
  }

  void resetSourceState() {
    if (sourcePosition == null) {
      throw Exception(
          "Source position must be provided before reseting the source state");
    }
    sourceStateId = null;
    sourceStateCentered = null;
    sourceStateAngle = null;
  }

  void resetDestinationState() {
    if (destinationPosition == null) {
      throw Exception(
          "Destination position must be provided before reseting the destination state");
    }
    destinationStateId = null;
    destinationStateCentered = null;
    destinationStateAngle = null;
  }

  void resetSourcePosition() {
    if (sourceState == null) {
      throw Exception(
          "Source state must be provided before reseting the source position");
    }
    if (sourceStateCentered ?? false ? false : sourceStateAngle == null) {
      throw Exception(
          "If source state is not centered or not provided, source state angle must be provided");
    }
    sourcePosition = null;
  }

  void resetDestinationPosition() {
    if (destinationState == null) {
      throw Exception(
          "Destination state must be provided before reseting the destination position");
    }
    if (destinationStateCentered ?? false
        ? false
        : destinationStateAngle == null) {
      throw Exception(
          "If destination state is not centered or not provided, destination state angle must be provided");
    }
    destinationPosition = null;
  }

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'sourceState': sourceState,
      'destinationState': destinationState,
      'sourceStateCentered': sourceStateCentered,
      'destinationStateCentered': destinationStateCentered,
      'sourceStateAngle': sourceStateAngle,
      'destinationStateAngle': destinationStateAngle,
      'sourcePosition': sourcePosition,
      'destinationPosition': destinationPosition,
    }.toString();
  }
}
