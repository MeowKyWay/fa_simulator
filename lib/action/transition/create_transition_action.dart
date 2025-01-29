import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

class CreateTransitionAction extends AppAction {
  final Offset? sourcePosition;
  final Offset? destinationPosition;

  final String? sourceStateId;
  final String? destinationStateId;

  final String label;

  late TransitionType transition;

  CreateTransitionAction({
    this.sourcePosition,
    this.destinationPosition,
    this.sourceStateId,
    this.destinationStateId,
    this.label = '',
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    transition = addTransition(
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      sourceStateId: sourceStateId,
      destinationStateId: destinationStateId,
      label: label,
    );
    requestFocus([transition.id]);
  }

  @override
  Future<void> undo() async {
    deleteTransition(transition.id);
  }

  @override
  Future<void> redo() async {
    addTransition(
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      sourceStateId: sourceStateId,
      destinationStateId: destinationStateId,
      label: label,
      id: transition.id,
    );
    requestFocus([transition.id]);
  }
}
