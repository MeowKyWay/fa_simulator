import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';

class DiagramSave {
  void save(String filePath) async {
    List<DiagramType> items = DiagramList().items;
    try {
      String jsonString = jsonEncode(items.map((item) => item.toJson()).toList());

      File file = File(filePath);
      await file.writeAsString(jsonString);
    }
    catch (e) {
      log('Failed to save diagram: $e');
    }
  }
}