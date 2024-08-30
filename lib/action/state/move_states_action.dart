import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
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
    for (int i = 0; i < stateIds.length; i++) {
      oldPositions.add(StateList().moveState(stateIds[i], distance));
    }
  }

  @override
  void undo() {
    for (int i = 0; i < stateIds.length; i++) {
      StateList().moveState(stateIds[i], -distance);
    }
    oldPositions.clear();
  }

  @override
  void redo() {
    execute();
  }
}
