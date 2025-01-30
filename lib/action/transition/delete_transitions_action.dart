import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';

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
    List<DiagramCommand> commands = [];

    transitions.clear();
    transitions.addAll(DiagramList().getTransitionsByIds(ids));
    for (String i in ids) {
      commands.add(DeleteTransitionCommand(id: i));
    }

    DiagramList().executeCommands(commands);
  }

  @override
  Future<void> undo() async {
    List<DiagramCommand> commands = [];

    for (var i = 0; i < transitions.length; i++) {
      commands.add(AddTransitionCommand(transition: transitions[i]));
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(ids);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
