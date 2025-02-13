import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';

class ChangeDiagramTypeAction extends AppAction {
  final AutomataType type;

  ChangeDiagramTypeAction({
    required this.type,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    DiagramList().type = type;
  }

  @override
  Future<void> undo() async {
    DiagramList().type =
        type == AutomataType.dfa ? AutomataType.nfa : AutomataType.dfa;
  }

  @override
  Future<void> redo() async {
    DiagramList().type = type;
  }
}
