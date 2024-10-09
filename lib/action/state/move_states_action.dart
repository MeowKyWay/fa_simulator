import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:flutter/material.dart';

class MoveStatesAction extends AppAction {
  final List<String> stateIds;
  final Offset distance;
  final List<Offset> oldPositions = [];

  MoveStatesAction(
    this.stateIds,
    this.distance,
  );

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    unfocus();
    for (String id in stateIds) {
      oldPositions.add(moveState(id, distance));
    }
    addFocus(stateIds);
  }

  @override
  void undo() {
    for (String id in stateIds) {
      moveState(id, -distance);
    }
    addFocus(stateIds);
    oldPositions.clear();
  }

  @override
  void redo() {
    execute();
  }
}
