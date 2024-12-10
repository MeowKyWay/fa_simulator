import 'dart:developer';

import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';

class DeleteDiagramsAction extends AppAction {
  final List<String> ids;
  final Set<StateType> states = {};
  final Set<TransitionType> transitions = {};

  DeleteDiagramsAction({
    required this.ids,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    transitions.clear();
    states.clear();
    transitions.addAll(
        DiagramList().transitions.where((element) => ids.contains(element.id)));
    states.addAll(
        DiagramList().states.where((element) => ids.contains(element.id)));
    for (TransitionType i in transitions) {
      deleteTransition(i.id);
    }
    log("==========");
    log(states.toString());
    for (StateType i in states) {
      log(i.id);
      if (i.transitionIds.isNotEmpty) {
        throw Exception("Cannot delete a state that has transitions");
      }
      deleteState(i.id);
    }
  }

  @override
  void undo() {
    for (TransitionType i in transitions) {
      addTransition(
        sourcePosition: i.sourcePosition,
        destinationPosition: i.destinationPosition,
        sourceStateId: i.sourceStateId,
        destinationStateId: i.destinationStateId,
        label: i.label,
        id: i.id,
      );
    }
    for (StateType i in states) {
      addState(i.position, i.label, i.id);
    }

    requestFocus(ids);
  }

  @override
  void redo() {
    execute();
  }
}
