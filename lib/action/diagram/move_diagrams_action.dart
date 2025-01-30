import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

class TransitionMoveInfo {
  final String id;
  final String? oldSourceStateId;
  final String? oldDestinationStateId;

  TransitionMoveInfo({
    required this.id,
    this.oldSourceStateId,
    this.oldDestinationStateId,
  });
}

class MoveDiagramsAction extends AppAction {
  final Iterable<String> ids;
  final Offset deltaOffset;
  final List<TransitionMoveInfo> moveInfos = [];

  MoveDiagramsAction({
    required this.ids,
    required this.deltaOffset,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    List<DiagramCommand> commands = [];

    for (String id in ids) {
      DiagramType item;
      try {
        item = DiagramList().item(id);
      } catch (e) {
        continue;
      }

      if (item is TransitionType) {
        TransitionPivotType pivotType = TransitionPivotType.all;
        TransitionMoveInfo moveInfo = TransitionMoveInfo(
          id: id,
          oldSourceStateId: item.sourceStateId,
          oldDestinationStateId: item.destinationStateId,
        );
        moveInfos.add(moveInfo);
        if (ids.contains(item.sourceStateId)) {
          if (ids.contains(item.destinationStateId)) {
            continue;
          }
          pivotType = TransitionPivotType.end;
        }
        if (ids.contains(item.destinationStateId)) {
          pivotType = TransitionPivotType.start;
        }
        commands.add(MoveTransitionCommand(
          id: id,
          pivotType: pivotType,
          distance: deltaOffset,
        ));
      }
      if (item is StateType) {
        commands.add(MoveStateCommand(
          id: id,
          distance: deltaOffset,
        ));
      }
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(ids);
  }

  @override
  Future<void> undo() async {
    List<DiagramCommand> commands = [];

    for (String id in ids) {
      DiagramType item;
      try {
        item = DiagramList().item(id);
      } catch (e) {
        continue;
      }

      if (item is StateType) {
        commands.add(MoveStateCommand(
          id: id,
          distance: -deltaOffset,
        ));
      }
      if (item is TransitionType) {
        TransitionMoveInfo moveInfo = moveInfos.firstWhere(
          (element) => element.id == id,
        );

        TransitionPivotType? pivotType;

        if (ids.contains(item.sourceStateId) &&
            ids.contains(item.destinationStateId)) {
          continue;
        }
        if (moveInfo.oldSourceStateId != null) {
          commands.add(AttachTransitionCommand(
            id: id,
            pivotType: TransitionEndPointType.start,
            stateId: moveInfo.oldSourceStateId!,
          ));
          pivotType = TransitionPivotType.end;
        }
        if (moveInfo.oldDestinationStateId != null) {
          commands.add(AttachTransitionCommand(
            id: id,
            pivotType: TransitionEndPointType.end,
            stateId: moveInfo.oldDestinationStateId!,
          ));
          pivotType = (pivotType == TransitionPivotType.end)
              ? null
              : TransitionPivotType.start;
        }
        if (pivotType != null) {
          commands.add(
            MoveTransitionCommand(
                id: id, pivotType: pivotType, distance: -deltaOffset),
          );
        }
      }
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(ids);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
