import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';

class DeleteDiagramsAction extends AppAction {
  final Iterable<String> ids;
  final List<StateType> states = [];
  final List<TransitionType> transitions = [];

  DeleteDiagramsAction({
    required this.ids,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    transitions.clear();
    states.clear();

    List<DiagramCommand> commands = [];

    transitions.addAll(
        DiagramList().transitions.where((element) => ids.contains(element.id)));
    states.addAll(
        DiagramList().states.where((element) => ids.contains(element.id)));
    for (TransitionType i in transitions) {
      commands.add(DeleteItemCommand(id: i.id));
    }
    for (StateType i in states) {
      commands.add(DeleteItemCommand(id: i.id));
    }
    FocusProvider().removeFocusAll(ids);
    DiagramList().executeCommands(commands);
  }

  @override
  Future<void> undo() async {
    List<AddItemCommand> commands = [];

    for (StateType i in states) {
      commands.add(AddItemCommand(item: i));
    }
    for (TransitionType i in transitions) {
      commands.add(AddItemCommand(item: i));
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(ids);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
