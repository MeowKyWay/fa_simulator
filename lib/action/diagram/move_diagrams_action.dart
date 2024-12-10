import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

class MoveDiagramsAction extends AppAction {
  final List<String> ids;
  final Offset deltaOffset;

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

      if (item is StateType) {
        moveState(id, deltaOffset);
      }
      if (item is TransitionType) {
        // moveTransition(id: id, pivotType: pivotType, distance: distance);
      }
    }
  }

  @override
  void undo() {
  }

  @override
  void redo() {
  }
}
