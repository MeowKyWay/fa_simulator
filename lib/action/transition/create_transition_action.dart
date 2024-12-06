import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:flutter/material.dart';

class CreateTransitionAction extends AppAction {

  final Offset? sourcePosition;
  final Offset? destinationPosition;

  final StateType? sourceState;
  final StateType? destinationState;

  final bool? sourceStateCentered;
  final bool? destinationStateCentered;
  final double? sourceStateAngle;
  final double? destinationStateAngle;

  final String label;

  late TransitionType transition;

  CreateTransitionAction({
    this.sourcePosition,
    this.destinationPosition,
    this.sourceState,
    this.destinationState,
    this.sourceStateCentered,
    this.destinationStateCentered,
    this.sourceStateAngle,
    this.destinationStateAngle,
    this.label = "",
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    transition = addTransition(
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      sourceState: sourceState,
      destinationState: destinationState,
      sourceStateCentered: sourceStateCentered,
      destinationStateCentered: destinationStateCentered,
      sourceStateAngle: sourceStateAngle,
      destinationStateAngle: destinationStateAngle,
      label: label,
    );
    //TODO add focus
  }

  @override
  void undo() {
    deleteTransition(transition.id);
  }

  @override
  void redo() {
    addTransition(
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      sourceState: sourceState,
      destinationState: destinationState,
      sourceStateCentered: sourceStateCentered,
      destinationStateCentered: destinationStateCentered,
      sourceStateAngle: sourceStateAngle,
      destinationStateAngle: destinationStateAngle,
      label: label,
      id: transition.id,
    );
    //TODO add focus
  }
}