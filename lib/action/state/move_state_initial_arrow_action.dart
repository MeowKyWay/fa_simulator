import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class MoveStateInitialArrowAction extends AppAction {
  final String id;
  final double angle;

  late double _angle;

  MoveStateInitialArrowAction({
    required this.id,
    required this.angle,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    StateType state = DiagramList().state(id);
    _angle = state.initialArrowAngle;
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, initialArrowAngle: angle),
      ),
    );
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, initialArrowAngle: _angle),
      ),
    );
  }

  @override
  Future<void> redo() async {
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, initialArrowAngle: angle),
      ),
    );
  }
}
