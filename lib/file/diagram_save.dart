import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:file_selector/file_selector.dart';

class DiagramSave {
  void save(String filePath) async {
    List<DiagramType> items = DiagramList().itemsCopy;
    try {
      String jsonString =
          jsonEncode(items.map((item) => item.toJson()).toList());

      File file = File(filePath);
      FileProvider().fileName = file.path.split('/').last;
      FileProvider().filePath = file.path;
      await file.writeAsString(jsonString);

      FileProvider().savedItem = items;

      log('Diagram saved to ${file.absolute}');
    } catch (e) {
      log('Failed to save diagram: $e');
    }
  }

  Future<void> saveAs() async {
    String fileName = FileProvider().fileName ?? 'new_diagram.dfa';
    final FileSaveLocation? result = await getSaveLocation(
      suggestedName: fileName,
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'DFA Diagram',
          extensions: ['dfa'],
        ),
        XTypeGroup(
          label: 'NFA Diagram',
          extensions: ['nfa'],
        )
      ],
    );
    if (result == null) {
      // Operation was canceled by the user.
      return;
    }

    save(result.path);
  }
}
