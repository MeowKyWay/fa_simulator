import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

//This action only work when moving transition pivot from state/position to another position
//Cannot attaching transition to a state
class MoveTransitionActionInput {
  final String id;
  final TransitionPivotType pivotType;
  String? oldStateId;
  bool? isCentered;
  double? angle;

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
      TransitionType transition = DiagramList().transition(input.id)!;
      switch (input.pivotType) {
        case TransitionPivotType.start:
          input.oldStateId = transition.sourceStateId;
          break;
        case TransitionPivotType.end:
          input.oldStateId = transition.destinationStateId;
          break;
        default:
          break;
      }
      moveTransition(
        id: input.id,
        pivotType: input.pivotType,
        distance: deltaOffset,
      );
    }
    addFocus(inputs.map((item) => item.id).toList());
  }

  @override
  void undo() {
    //TODO if the action detached the transition from the state, the transition should be reattached to the state
    for (MoveTransitionActionInput input in inputs) {
      if (input.oldStateId != null) {
        attachTransition(
          id: input.id,
          stateId: input.oldStateId!,
          endPoint: input.pivotType == TransitionPivotType.start
              ? TransitionEndPointType.start
              : TransitionEndPointType.end,
        );
        return;
      }
      moveTransition(
        id: input.id,
        pivotType: input.pivotType,
        distance: -deltaOffset,
      );
    }
    addFocus(inputs.map((item) => item.id).toList());
  }

  @override
  void redo() {
    execute();
  }
}
