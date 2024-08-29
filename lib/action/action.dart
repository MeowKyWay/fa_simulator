import 'dart:developer';

import 'package:fa_simulator/widget/diagram/state/state_list.dart';
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
    StateList().requestFocus(state.id);
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
    StateList().unfocus();
    for (var i = 0; i < states.length; i++) {
      StateList().addState(states[i].position, states[i].name, states[i].id);
      StateList().addFocus(states[i].id);
    }
  }

  @override
  void redo() {
    execute();
  }
}

class RenameStateAction implements AppAction {
  final String id;
  final String name;
  late String oldName;

  RenameStateAction(
    this.id,
    this.name,
  );

  @override
  void execute() {
    oldName = StateList().renameState(id, name);
    StateList().endRename();
  }

  @override
  void undo() {
    StateList().renameState(id, oldName);
  }

  @override
  void redo() {
    execute();
  }
}
