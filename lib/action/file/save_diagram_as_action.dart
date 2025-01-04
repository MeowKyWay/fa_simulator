import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_save.dart';

class SaveDiagramAsAction extends AppUnrevertableAction {
  @override
  bool get isRevertable => false;

  @override
  Future<void> execute() async {
    DiagramSave().saveAs();
  }
}