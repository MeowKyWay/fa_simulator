import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:tuple/tuple.dart';

class DeleteDiagramsAction extends AppAction {
  final Iterable<String> ids;
  final List<StateType> states = [];
  final List<TransitionType> transitions = [];

  final List<Tuple3<String, String, TransitionEndPointType>> transitionPivots =
      [];

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
      for (String j in DiagramList().transitionsOfState(i.id)) {
        if (transitions.any((element) => element.id == j)) {
          continue;
        }
        TransitionType transition = DiagramList().transition(j);
        TransitionEndPointType pivotType = transition.sourceState?.id == i.id
            ? TransitionEndPointType.start
            : TransitionEndPointType.end;
        transitionPivots.add(Tuple3(transition.id, i.id, pivotType));
        commands.add(
          MoveTransitionCommand(
              id: transition.id,
              pivotType: pivotType.pivotType,
              position: transition.endPointPosition(pivotType)),
        );
      }
      commands.add(DeleteItemCommand(id: i.id));
    }
    FocusProvider().removeFocusAll(ids);
    DiagramList().executeCommands(commands);
  }

  @override
  Future<void> undo() async {
    List<DiagramCommand> commands = [];

    for (StateType i in states) {
      commands.add(AddItemCommand(item: i));
    }
    for (TransitionType i in transitions) {
      commands.add(AddItemCommand(item: i));
    }
    for (Tuple3<String, String, TransitionEndPointType> i in transitionPivots) {
      TransitionType transition = DiagramList().transition(i.item1);
      commands.add(
        AttachTransitionCommand(
          id: transition.id,
          pivotType: i.item3,
          stateId: i.item2,
        ),
      );
    }
    DiagramList().executeCommands(commands);
    FocusProvider().requestFocusAll(ids);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
