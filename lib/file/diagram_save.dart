import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/resource/diagram_constants.dart';
import 'package:file_selector/file_selector.dart';

class DiagramSave {
  Future<void> save(String filePath, [bool shouldSaveDiagram = true]) async {
    log('Saving diagram to $filePath');
    try {
      final json = DiagramList().toJson();
      final jsonString = jsonEncode(json);

      File file = File(filePath);

      if (shouldSaveDiagram) {
        DiagramList().name = file.path
            .split(DiagramPlatformConstant.fileSplitter)
            .last
            .split('.')
            .first;
        DiagramList().path = file.path;
        DiagramList().isSaved = true;
        DiagramList().notify();
      }
      await file.writeAsString(jsonString);
    } catch (e) {
      log('Failed to save diagram: $e');
    }
  }

  Future<void> saveAs([bool shouldSaveDiagram = false]) async {
    String fileName =
        '${DiagramList().name ?? 'Untitled'}.${DiagramList().type.toString()}';

    final FileSaveLocation? result = await getSaveLocation(
      suggestedName: fileName,
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'Diagram',
          extensions: [DiagramList().type.toString()],
        ),
      ],
    );

    if (result == null) {
      log('User canceled save operation.');
      return;
    }

    log('User selected save path: ${result.path}');

    try {
      // Ensure we have write permission
      File file = File(result.path);
      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      await save(result.path, shouldSaveDiagram);
    } catch (e) {
      log('Failed to save file: $e');
    }
  }
}
