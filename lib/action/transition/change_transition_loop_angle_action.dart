import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class ChangeTransitionLoopAngleAction extends AppAction {
  String id;
  double angle;
  late double oldAngle;

  ChangeTransitionLoopAngleAction({
    required this.id,
    required this.angle,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    oldAngle = DiagramList().transition(id).loopAngle;
    DiagramList().executeCommand(
      UpdateTransitionCommand(
        detail: TransitionDetail(id: id, loopAngle: angle),
      ),
    );
    FocusProvider().requestFocus(id);
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(
      UpdateTransitionCommand(
        detail: TransitionDetail(id: id, loopAngle: oldAngle),
      ),
    );
  }

  @override
  Future<void> redo() async {
    DiagramList().executeCommand(
      UpdateTransitionCommand(
        detail: TransitionDetail(id: id, loopAngle: angle),
      ),
    );
    FocusProvider().requestFocus(id);
  }
}
