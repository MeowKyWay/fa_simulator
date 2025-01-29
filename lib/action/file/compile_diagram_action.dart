import 'dart:developer';

import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_compile.dart';
import 'package:fa_simulator/file/diagram_save.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

class CompileDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    String? path = FileProvider().filePath;
    if (path == null) {
      log('Path is null, calling saveAs()');
      await DiagramSave().saveAs();
    } else {
      await DiagramSave().save(path);
    }
    path = FileProvider().filePath!;
    path = '${path.substring(0, path.lastIndexOf('.'))}.faout';
    DiagramCompile().compile(path);
  }
}
