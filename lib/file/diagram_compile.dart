import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';

class DiagramCompile {
  Future<void> compile(String filePath) async {
    try {
      String jsonString = jsonEncode(DiagramList().compiler.toJson());

      File file = File(filePath);
      await file.writeAsString(jsonString);
      log('Compile to ${file.absolute}');
    } catch (e) {
      log('Failed to compile diagram: $e');
    }
  }
}
