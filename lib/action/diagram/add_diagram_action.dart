import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';

class AddDiagramAction extends AppAction {
  final DiagramType item;

  AddDiagramAction({
    required this.item,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    DiagramList().items.add(item);
    requestFocus([item.id]);
    DiagramList().notify();
  }

  @override
  void undo() {
    DiagramList().items.remove(item);
    DiagramList().notify();
  }

  @override
  void redo() {
    execute();
  }
}
