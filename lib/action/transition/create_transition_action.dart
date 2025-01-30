import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
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
    transition = TransitionType(
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      sourceStateId: sourceStateId,
      destinationStateId: destinationStateId,
      label: label,
    );
    DiagramList().executeCommand(AddTransitionCommand(transition: transition));
    FocusProvider().requestFocus(transition.id);
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(DeleteTransitionCommand(id: transition.id));
  }

  @override
  Future<void> redo() async {
    DiagramList().executeCommand(AddTransitionCommand(transition: transition));
    FocusProvider().requestFocus(transition.id);
  }
}
