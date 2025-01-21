import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
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
    StateType state = DiagramList().state(id)!;
    _angle = state.initialArrowAngle;
    moveStateInitialArrow(id, angle);
  }

  @override
  Future<void> undo() async {
    moveStateInitialArrow(id, _angle);
  }

  @override
  Future<void> redo() async {
    moveStateInitialArrow(id, angle);
  }
}