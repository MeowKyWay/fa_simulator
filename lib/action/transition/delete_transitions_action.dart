import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';

class DeleteTransitionsAction extends AppAction {
  final List<String> ids;
  final List<TransitionType> transitions = [];

  DeleteTransitionsAction({
    required this.ids,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    transitions.clear();
    transitions.addAll(DiagramList().getTransitions(ids));
    for (String i in ids) {
      deleteTransition(i);
    }
  }

  @override
  Future<void> undo() async {
    for (var i = 0; i < transitions.length; i++) {
      addTransition(
        sourcePosition: transitions[i].sourcePosition,
        destinationPosition: transitions[i].destinationPosition,
        sourceStateId: transitions[i].sourceStateId,
        destinationStateId: transitions[i].destinationStateId,
        label: transitions[i].label,
        id: transitions[i].id,
      );
    }
    requestFocus(transitions.map((e) => e.id).toList());
  }

  @override
  Future<void> redo() async {
    execute();
  }
}