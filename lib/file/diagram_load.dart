import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/accept_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/start_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
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
      FileProvider().fileName = file.name;
      FileProvider().filePath = file.path;
      FileProvider().faType =
          file.name.split('.').last == 'dfa' ? FAType.dfa : FAType.nfa;
      _load(File(file.path));
    } else {
      // If no file was selected
      log('No file selected.');
    }
  }

  Future<void> _load(File file) async {
    try {
      String fileContent = await file.readAsString();

      // Decode the JSON into a List of Maps
      List<dynamic> jsonList = jsonDecode(fileContent);

      // If the content is a list of JSON objects, you can cast it to List<Map<String, dynamic>>
      List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(jsonList);

      // Example: Accessing a specific element
      List<StateType> states = [];
      List<TransitionType> transitions = [];
      for (var item in dataList) {
        if (item['type'] == 'state') {
          states.add(StateType.fromJson(item));
        } else if (item['type'] == 'start_state') {
          states.add(StartStateType.fromJson(item));
        } else if (item['type'] == 'accept_state') {
          states.add(AcceptStateType.fromJson(item));
        } else if (item['type'] == 'transition') {
          transitions.add(TransitionType.fromJson(item));
        }
      }
      DiagramList().addItems(states);
      DiagramList().addItems(transitions);
    } catch (e) {
      log('Error reading JSON file: $e');
    }
  }
}
