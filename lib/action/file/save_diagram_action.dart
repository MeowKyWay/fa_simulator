import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/file/diagram_save.dart';

class SaveDiagramAction extends AppAction {
  @override
  bool get isRevertable => false;

  @override
  void execute() {
    DiagramSave().save('diagram.dfa');
  }

  @override
  void undo() {
  }

  @override
  void redo() {
  }
}