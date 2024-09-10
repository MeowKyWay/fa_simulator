import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:flutter/material.dart';

class CreateStateAction implements AppAction {
  final Offset position;
  final String name;
  late StateType state;

  CreateStateAction(
    this.position,
    this.name,
  );

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    state = StateList().addState(position, name);
    StateList().requestFocus(state.id);
    StateList().startRename(state.id);
  }

  @override
  void undo() {
    StateList().deleteState(state.id);
  }

  @override
  void redo() {
    StateList().addState(position, name, state.id);
    StateList().requestFocus(state.id);
  }
}
