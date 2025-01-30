import 'dart:developer';

import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_compile.dart';
import 'package:fa_simulator/file/diagram_save.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';

class CompileDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    String? path = DiagramList().file.path;
    if (path == null) {
      log('Path is null, calling saveAs()');
      await DiagramSave().saveAs();
    } else {
      await DiagramSave().save(path);
    }
    path = DiagramList().file.path!;
    path = '${path.substring(0, path.lastIndexOf('.'))}.faout';
    DiagramCompile().compile(path);
  }
}
