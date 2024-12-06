import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:flutter/material.dart';

class MoveStatesAction extends AppAction {
  final List<String> stateIds;
  final Offset deltaOffset;
  final List<Offset> oldPositions = [];

  MoveStatesAction({
    required this.stateIds,
    required this.deltaOffset,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    unfocus();
    for (String id in stateIds) {
      oldPositions.add(moveState(id, deltaOffset));
    }
    addFocus(stateIds);
  }

  @override
  void undo() {
    for (String id in stateIds) {
      moveState(id, -deltaOffset);
    }
    addFocus(stateIds);
    oldPositions.clear();
  }

  @override
  void redo() {
    execute();
  }
}
