import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:file_selector/file_selector.dart';

class DiagramSave {
  Future<void> save(String filePath) async {
    log('Saving diagram to $filePath');
    try {
      final json = DiagramList().toJson();
      final jsonString = jsonEncode(json);

      File file = File(filePath);
      DiagramList().file.name = file.path.split('/').last.split('.').first;
      DiagramList().file.path = file.path;
      await file.writeAsString(jsonString);

      DiagramList().file.isSaved = true;
      DiagramList().notify();
    } catch (e) {
      log('Failed to save diagram: $e');
    }
    DiagramList().file.isSaved = true;
  }

  Future<void> saveAs() async {
    String fileName =
        '${DiagramList().file.name ?? 'Untitled'}.${DiagramList().type.toString()}';
    final FileSaveLocation? result = await getSaveLocation(
      suggestedName: fileName,
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'Diagram',
          extensions: ['dfa', 'nfa'],
        ),
      ],
    );
    if (result == null) {
      // Operation was canceled by the user.
      return;
    }

    save(result.path);
  }
}
