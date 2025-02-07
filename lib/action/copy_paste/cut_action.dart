import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';

class CutAction extends AppAction {
  final Set<StateType> states = {};
  final Set<TransitionType> transitions = {};

  @override
  bool isRevertable = true;

  @override
  Future<void> execute() async {
    List<DiagramType> focusedItems = FocusProvider().focusedItems;
    DiagramClipboard.copy(focusedItems);

    List<DiagramCommand> commands = [];

    transitions.addAll(focusedItems.whereType<TransitionType>());
    states.addAll(focusedItems.whereType<StateType>());
    for (TransitionType i in transitions) {
      commands.add(DeleteItemCommand(id: i.id));
    }
    for (StateType i in states) {
      commands.add(DeleteItemCommand(id: i.id));
    }

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
    FocusProvider().requestFocusAll(
      states.map((e) => e.id).followedBy(transitions.map((e) => e.id)),
    );
  }

  @override
  Future<void> redo() async {
    DiagramClipboard.copy(
      (states as Set<DiagramType>).followedBy(transitions).toList(),
    );

    List<DiagramCommand> commands = [];

    for (TransitionType i in transitions) {
      commands.add(DeleteItemCommand(id: i.id));
    }
    for (StateType i in states) {
      commands.add(DeleteItemCommand(id: i.id));
    }

    DiagramList().executeCommands(commands);
  }
}
