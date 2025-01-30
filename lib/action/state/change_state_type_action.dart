import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class ChangeStateTypeAction extends AppAction {
  final String id;
  final bool? isInitial;
  final bool? isFinal;

  late bool _isInitial;
  late bool _isFinal;

  ChangeStateTypeAction({
    required this.id,
    this.isInitial,
    this.isFinal,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    StateType state;
    state = DiagramList().state(id);

    _isInitial = state.isInitial;
    _isFinal = state.isFinal;
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, isInitial: isInitial, isFinal: isFinal),
      ),
    );
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, isInitial: _isInitial, isFinal: _isFinal),
      ),
    );
  }

  @override
  Future<void> redo() async {
    DiagramList().executeCommand(
      UpdateStateCommand(
        detail: StateDetail(id: id, isInitial: isInitial, isFinal: isFinal),
      ),
    );
  }
}
