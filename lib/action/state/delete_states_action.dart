import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class DeleteStatesAction implements AppAction {
  final List<String> stateIds;
  late List<StateType> states;

  DeleteStatesAction({
    required this.stateIds,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    states = DiagramList().getStates(stateIds);
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
