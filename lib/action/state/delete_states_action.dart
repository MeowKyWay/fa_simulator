import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';

class DeleteStatesAction implements AppAction {
  late List<StateType> states;

  DeleteStatesAction(
    this.states,
  );

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    for (var i = 0; i < states.length; i++) {
      deleteState(states[i].id);
    }
  }

  @override
  void undo() {
    for (var i = 0; i < states.length; i++) {
      addState(states[i].position, states[i].label, states[i].id);
    }
    requestFocus(states.map((e) => e.id).toList());
  }

  @override
  void redo() {
    execute();
  }
}
