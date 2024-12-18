import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/file/diagram_load.dart';

class OpenDiagramAction extends AppAction {
  @override
  bool get isRevertable => false;

  @override
  void execute() {
    DiagramLoad().load();
  }

  @override
  void undo() {
  }

  @override
  void redo() {
  }
}
