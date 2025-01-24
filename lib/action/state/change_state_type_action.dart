import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
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
    try {
      state = DiagramList().state(id)!;
    } catch (e) {
      throw Exception('change_state_type_action.dart: State not found');
    }

    _isInitial = state.isInitial;
    _isFinal = state.isFinal;
    changeStateType(id: id, isInitial: isInitial, isFinal: isFinal);
  }

  @override
  Future<void> undo() async {
    changeStateType(id: id, isInitial: _isInitial, isFinal: _isFinal);
  }

  @override
  Future<void> redo() async {
    changeStateType(id: id, isInitial: isInitial, isFinal: isFinal);
  }
}
