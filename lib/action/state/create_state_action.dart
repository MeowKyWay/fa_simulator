import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class CreateStateAction implements AppAction {
  final Offset position;
  final String name;
  late StateType state;

  CreateStateAction({
    required this.position,
    required this.name,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    state = StateType(position: position, label: name);
    DiagramList().executeCommand(AddStateCommand(state: state));
    FocusProvider().requestFocus(state.id);
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(DeleteStateCommand(id: state.id));
  }

  @override
  Future<void> redo() async {
    DiagramList().executeCommand(AddStateCommand(state: state));
    FocusProvider().requestFocus(state.id);
  }
}
