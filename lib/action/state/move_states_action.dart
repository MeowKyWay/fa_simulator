import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:flutter/material.dart';

class MoveStatesAction extends AppAction {
  final List<String> stateIds;
  final Offset deltaOffset;

  MoveStatesAction({
    required this.stateIds,
    required this.deltaOffset,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    for (String id in stateIds) {
      moveState(id, deltaOffset);
    }
    requestFocus(stateIds);
  }

  @override
  Future<void> undo() async {
    for (String id in stateIds) {
      moveState(id, -deltaOffset);
    }
    requestFocus(stateIds);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
