import 'dart:developer';

import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_save.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

class SaveDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    String? path = FileProvider().filePath;
    if (path == null) {
      log('Path is null, calling saveAs()');
      DiagramSave().saveAs();
      return;
    }
    DiagramSave().save(path);
  }
}
