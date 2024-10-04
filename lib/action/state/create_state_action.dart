import 'dart:developer';

import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
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
    state = addState(position, name);
    requestFocus([state.id]);
  }

  @override
  void undo() {
    deleteState(state.id);
  }

  @override
  void redo() {
    log(name);
    addState(position, name, state.id);
    requestFocus([state.id]);
  }
}
