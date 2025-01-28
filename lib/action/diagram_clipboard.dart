import 'dart:developer';

import 'package:fa_simulator/widget/components/extension/list_extension.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:flutter/services.dart';

class DiagramClipboard {
  static final DiagramClipboard _instance = DiagramClipboard._internal();
  DiagramClipboard._internal();
  factory DiagramClipboard() {
    return _instance;
  }

  final List<DiagramType> _items = [];
  int _count = 0;

  int get count => _count;

  void incrementCount() {
    _count++;
  }

  void decrementCount() {
    _count--;
  }

  void resetCount() {
    _count = 0;
  }

  List<DiagramType> get items => _items;

  static void copy(List<DiagramType> items) {
    String json = items.toJson();
    log('Copied: $json');
    Clipboard.setData(
      ClipboardData(text: json),
    );
  }

  static Future<List<DiagramType>> getItems() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data == null) {
      return [];
    }
    String json = data.text ?? '';
    log('Pasted: $json');
    return ListExtension.fromJson(json);
  }
}
