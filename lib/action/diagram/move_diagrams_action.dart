import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
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
  final List<String> ids;
  final Offset deltaOffset;
  final List<TransitionMoveInfo> moveInfos = [];

  MoveDiagramsAction({
    required this.ids,
    required this.deltaOffset,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    for (String id in ids) {
      DiagramType? item = DiagramList().item(id);
      if (item == null) {
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
        moveTransition(
          id: id,
          pivotType: pivotType,
          distance: deltaOffset,
        );
      }
      if (item is StateType) {
        moveState(id, deltaOffset);
      }
    }
    requestFocus(ids);
  }

  @override
  void undo() {
    for (String id in ids) {
      DiagramType? item = DiagramList().item(id);
      if (item == null) {
        continue;
      }

      if (item is StateType) {
        moveState(id, -deltaOffset);
      }
      if (item is TransitionType) {
        TransitionMoveInfo moveInfo = moveInfos.firstWhere(
          (element) => element.id == id,
        );

        TransitionPivotType? pivotType;

        if (moveInfo.oldSourceStateId != null) {
          attachTransition(
            id: id,
            stateId: moveInfo.oldSourceStateId!,
            endPoint: TransitionEndPointType.start,
          );
          pivotType = TransitionPivotType.end;
        }
        if (moveInfo.oldDestinationStateId != null) {
          attachTransition(
            id: id,
            stateId: moveInfo.oldDestinationStateId!,
            endPoint: TransitionEndPointType.end,
          );
          pivotType = (pivotType == TransitionPivotType.end)
              ? null
              : TransitionPivotType.start;
        }
        if (pivotType != null) {
          moveTransition(
            id: id,
            pivotType: pivotType,
            distance: -deltaOffset,
          );
        }
      }
    }
    requestFocus(ids);
  }

  @override
  void redo() {
    execute();
  }
}
