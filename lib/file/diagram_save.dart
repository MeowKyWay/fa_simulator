import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:file_selector/file_selector.dart';
// import 'package:file_picker/file_picker.dart';

class DiagramSave {
  void save(String filePath) async {
    List<DiagramType> items = DiagramList().items;
    try {
      String jsonString =
          jsonEncode(items.map((item) => item.toJson()).toList());

      File file = File(filePath);
      await file.writeAsString(jsonString);
      log('Diagram saved to ${file.absolute}');
    } catch (e) {
      log('Failed to save diagram: $e');
    }
  }

  Future<void> saveAs() async {
    // Specify the suggested file name and types.
    const String suggestedName = 'newfile.txt';
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'Text Files',
      extensions: ['txt', 'md', 'csv'],
    );

    // Open the "Save As" dialog.
    final path = await getSaveLocation(
      suggestedName: suggestedName,
      acceptedTypeGroups: [typeGroup],
      confirmButtonText: 'Save',
    );

    if (path != null) {
      save(path.path);
    }
  }
}
