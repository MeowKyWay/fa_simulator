import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:flutter/material.dart';

class PasteAction extends AppAction {
  @override
  bool isRevertable = true;

  final List<DiagramType> _items = [];

  @override
  void execute() {
    List<DiagramType> items = DiagramClipboard().items;

    DiagramClipboard().incrementCount();

    Offset margin = const Offset(subGridSize, subGridSize) *
        DiagramClipboard().count.toDouble();

    for (DiagramType item in items) {
      DiagramType? newItem;
      if (item is StateType) {
        newItem = addState(item.position + margin, item.name);
      } else if (item is TransitionType) {
        //TODO implement
      }
      if (newItem != null) _items.add(newItem);
    }
    requestFocus(_items.map((e) => e.id).toList());
  }

  @override
  void undo() {
    DiagramClipboard().decrementCount();
    for (DiagramType item in _items) {
      if (item is StateType) {
        deleteState(item.id);
      } else if (item is TransitionType) {
        //TODO implement
      }
    }
  }

  @override
  void redo() {
    for (DiagramType item in _items) {
      if (item is StateType) {
        addState(item.position, item.name, item.id);
      } else if (item is TransitionType) {
        //TODO implement
      }
    }
    requestFocus(_items.map((e) => e.id).toList());
  }
}
