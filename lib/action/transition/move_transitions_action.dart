import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:flutter/material.dart';

//This action only work when moving transition pivot from state/position to another position
//Cannot attaching transition to a state
class MoveTransitionActionInput {
  final String id;
  final TransitionPivotType pivotType;

  MoveTransitionActionInput({
    required this.id,
    required this.pivotType,
  });
}

class MoveTransitionsAction extends AppAction {
  final List<MoveTransitionActionInput> inputs;
  final Offset deltaOffset;

  MoveTransitionsAction({
    required this.inputs,
    required this.deltaOffset,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    //TODO if the center pivot is null do not move on multiple selection move
    unfocus();
    for (MoveTransitionActionInput input in inputs) {
      moveTransition(input.id, input.pivotType, deltaOffset);
    }
    addFocus(inputs.map((item) => item.id).toList());
  }

  @override
  void undo() {
    for (MoveTransitionActionInput input in inputs) {
      moveTransition(input.id, input.pivotType, -deltaOffset);
    }
    addFocus(inputs.map((item) => item.id).toList());
  }

  @override
  void redo() {
    execute();
  }
}