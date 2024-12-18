import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class DeleteStatesAction implements AppAction {
  final List<String> ids;
  final List<StateType> states = [];

  DeleteStatesAction({
    required this.ids,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    states.clear();
    states.addAll(DiagramList().getStates(ids));
    for (var i = 0; i < states.length; i++) {
      try {
        if (DiagramList().state(states[i].id)!.transitionIds.isNotEmpty) {
          throw Exception("Cannot delete a state that has transitions");
        }
      } catch (e) {
        throw Exception("Cannot fint state ${states[i].id}");
      }
      deleteState(states[i].id);
    }
  }

  @override
  void undo() {
    for (var i = 0; i < states.length; i++) {
      addState(
        position: states[i].position,
        name: states[i].label,
        id: states[i].id,
      );
    }
    requestFocus(states.map((e) => e.id).toList());
  }

  @override
  void redo() {
    execute();
  }
}
