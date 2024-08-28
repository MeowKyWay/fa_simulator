import 'package:fa_simulator/state_list.dart';
import 'package:flutter/material.dart';

abstract class AppAction {
  // Do the action
  void execute();
  // Undo the action
  void undo();
  // Redo the action usually the same as execute
  void redo();
}

// Create a state action
class CreateStateAction implements AppAction {
  final Offset position;
  final String name;
  late DiagramState state;

  CreateStateAction(
    this.position,
    this.name,
  );

  @override
  void execute() {
    state = StateList().addState(position, name);
  }

  @override
  void undo() {
    StateList().deleteState(state.id);
  }

  @override
  void redo() {
    execute();
  }
}

// Delete states action
class DeleteStatesAction implements AppAction {
  late List<DiagramState> states;

  DeleteStatesAction(
    this.states,
  );

  @override
  void execute() {
    for (var i = 0; i < states.length; i++) {
      StateList().deleteState(states[i].id);
    }
  }

  @override
  void undo() {
    for (var i = 0; i < states.length; i++) {
      StateList().addState(states[i].position, states[i].name);
    }
  }

  @override
  void redo() {
    execute();
  }
}
