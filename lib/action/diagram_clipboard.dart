import 'dart:convert';

import 'package:fa_simulator/widget/components/extension/list_extension.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:flutter/services.dart';

class DiagramClipboard {
  static final DiagramClipboard _instance = DiagramClipboard._internal();
  DiagramClipboard._internal();
  factory DiagramClipboard() {
    return _instance;
  }

  static void copy(List<DiagramType> items) {
    Offset mousePosition = BodyProvider().mousePosition;

    String json = jsonEncode({
      'items': items.toJson(),
      'mousePosition': {
        'dx': mousePosition.dx,
        'dy': mousePosition.dy
      }, // Convert Offset to JSON-compatible format
    });

    Clipboard.setData(
      ClipboardData(text: json),
    );
  }

  static Future<Map<String, dynamic>> getData() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data == null) {
      return {};
    }
    return jsonDecode(data.text ?? '');
  }
}
