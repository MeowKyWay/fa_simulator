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
  final StateType? sourceState;
  final StateType? destinationState;
  final bool? sourceStateCentered;
  final bool? destinationStateCentered;

  final double? sourceStateAngle;
  final double? destinationStateAngle;

  final Offset? sourcePosition;
  final Offset? destinationPosition;

  final Offset? centerPivot;

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
    this.centerPivot,
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

  double get startAngle {
    return (startPosition-endPosition).direction;
  }

  double get endAngle {
    return (endPosition-startPosition).direction;
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
