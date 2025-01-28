// Request focus for a state
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';

void requestFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id);
  }
  RenamingProvider().reset();
  DiagramList().notify();
}

void addFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) || item.hasFocus;
  }
  RenamingProvider().reset();
  DiagramList().notify();
}

void removeFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = !ids.contains(item.id) && item.hasFocus;
  }
  RenamingProvider().reset();
  DiagramList().notify();
}

void toggleFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) ? !item.hasFocus : item.hasFocus;
  }
  RenamingProvider().reset();
  DiagramList().notify();
}

void unfocus() {
  bool changeFlag = false;
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    changeFlag = changeFlag || item.hasFocus;
    item.hasFocus = false;
  }
  RenamingProvider().reset();
  if (changeFlag) DiagramList().notify();
}
