import 'dart:convert';
import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';

extension ListExtension on List<DiagramType> {
  String toJson() {
    String json = jsonEncode(map((e) => e.toJson()).toList());
    return json;
  }

  static List<DiagramType> fromJson(String json) {
    List<dynamic> list = jsonDecode(json);
    List<DiagramType> items = [];
    for (Map<String, dynamic> map in list) {
      try {
        switch (map['type']) {
          case 'state':
            items.add(StateType.fromJson(map));
            break;
          case 'transition':
            items.add(TransitionType.fromJson(map));
            break;
        }
      } on Exception catch (e) {
        log('Error parsing DiagramType from JSON: $e');
        continue;
      }
    }
    return items;
  }
}
