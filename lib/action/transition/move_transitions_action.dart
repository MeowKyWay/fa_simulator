import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
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
  Future<void> execute() async {
    List<DiagramCommand> commands = [];

    for (MoveTransitionActionInput input in inputs) {
      TransitionType transition = DiagramList().transition(input.id);
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
      commands.add(
        MoveTransitionCommand(
          id: input.id,
          pivotType: input.pivotType,
          distance: deltaOffset,
        ),
      );
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(inputs.map((item) => item.id));
  }

  @override
  Future<void> undo() async {
    List<DiagramCommand> commands = [];

    for (MoveTransitionActionInput input in inputs) {
      if (input.oldStateId != null) {
        commands.add(
          AttachTransitionCommand(
            id: input.id,
            stateId: input.oldStateId!,
            pivotType: input.pivotType.endPointType,
          ),
        );
        continue;
      }
      commands.add(
        MoveTransitionCommand(
          id: input.id,
          pivotType: input.pivotType,
          distance: -deltaOffset,
        ),
      );
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(inputs.map((item) => item.id));
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
