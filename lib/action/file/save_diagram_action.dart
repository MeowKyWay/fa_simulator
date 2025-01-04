import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_save.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

class SaveDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    String? path = FileProvider().filePath;
    if (path == null) {
      DiagramSave().saveAs();
      return;
    }
    DiagramSave().save(path);
  }
}