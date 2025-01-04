import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_new.dart';

class NewDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    DiagramNew().newDiagram();
  }
}