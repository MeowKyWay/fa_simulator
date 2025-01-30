import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:file_selector/file_selector.dart';

class DiagramLoad {
  Future<void> load() async {
    // Function to open a file using FilePicker
    // Pick a file
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['dfa', 'nfa'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file != null) {
      resetProvider();
      DiagramList().file.name = file.name.split('.').first;
      DiagramList().file.path = file.path;
      DiagramList().type = AutomataType.fromString(file.name.split('.').last);
      _load(File(file.path));
    } else {
      // If no file was selected
      log('No file selected.');
      throw Exception('No file selected.');
    }
  }

  Future<void> _load(File file) async {
    try {
      String fileContent = await file.readAsString();

      // Decode the JSON into a List of Maps
      final jsonList = jsonDecode(fileContent);
      DiagramList().loadJson(jsonList);
    } catch (e) {
      log('Error reading JSON file: $e');
      throw Exception('Error reading JSON file: $e');
    }
  }
}
