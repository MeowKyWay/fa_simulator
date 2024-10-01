import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/clipboard.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:flutter/material.dart';

class PasteAction extends AppAction {
  @override
  bool isRevertable = false;

  List<DiagramType> _items = [];

  @override
  void execute() {
    List<DiagramType> items = DiagramClipboard().items;

    for (DiagramType item in items) {
      DiagramType newItem;
      if (item is StateType) {
        newItem =  StateList().addState(item.position + const Offset(10, 10), item.name);
      }
      else if (item is TransitionType) {
        //TODO implement
      }
      newItem = DiagramType(id: "error", name: "error");
      _items.add(newItem);
    }
  }

  @override
  void undo() {
    
  }

  @override
  void redo() {

  }
}