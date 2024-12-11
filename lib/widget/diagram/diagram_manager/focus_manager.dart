// Request focus for a state
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';

void requestFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id);
  }
  RenamingProvider().endRename();
  DiagramList().notify();
}

void addFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) || item.hasFocus;
  }
  RenamingProvider().endRename();
  DiagramList().notify();
}

void removeFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = !ids.contains(item.id) && item.hasFocus;
  }
  RenamingProvider().endRename();
  DiagramList().notify();
}

void toggleFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) ? !item.hasFocus : item.hasFocus;
  }
  RenamingProvider().endRename();
  DiagramList().notify();
}

void unfocus() {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = false;
  }
  RenamingProvider().endRename();
  DiagramList().notify();
}