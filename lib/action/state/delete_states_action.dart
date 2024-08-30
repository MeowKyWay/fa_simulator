import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';

class DeleteStatesAction implements AppAction {
  late List<DiagramState> states;

  DeleteStatesAction(
    this.states,
  );

  @override
  bool get isUndoable => true;

  @override
  void execute() {
    for (var i = 0; i < states.length; i++) {
      StateList().deleteState(states[i].id);
    }
  }

  @override
  void undo() {
    StateList().unfocus();
    for (var i = 0; i < states.length; i++) {
      StateList().addState(states[i].position, states[i].name, states[i].id);
      StateList().addFocus(states[i].id);
    }
  }

  @override
  void redo() {
    execute();
  }
}
