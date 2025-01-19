import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:flutter/material.dart';

class RenamingProvider extends DiagramProvider {
  //singleton
  static final RenamingProvider _singleton = RenamingProvider._internal();
  RenamingProvider._internal();
  factory RenamingProvider() {
    return _singleton;
  }

  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  String? _renamingItemId;

  String? get renamingItemId => _renamingItemId;

  void startRename({required String id, String? initialName}) {
    DiagramType? item = DiagramList().item(id);
    if (item == null) {
      throw Exception("renaming_provider/startRename: State not found");
    }
    _renamingItemId = id;
    _controller.clear();
    _controller.text = initialName ?? item.label;
    DiagramList().notify();
  }

  @override
  void reset() {
    _renamingItemId = null;
    _controller.clear();
    DiagramList().notify();
    KeyboardProvider().focusNode.requestFocus();
  }
}
