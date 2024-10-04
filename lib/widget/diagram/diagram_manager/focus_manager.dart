// Request focus for a state
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';

void requestFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id);
  }
  DiagramList().resetRename();
  DiagramList().notify();
}

void addFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) || item.hasFocus;
  }
  DiagramList().resetRename();
  DiagramList().notify();
}

void removeFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = !ids.contains(item.id) && item.hasFocus;
  }
  DiagramList().resetRename();
  DiagramList().notify();
}

void toggleFocus(List<String> ids) {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = ids.contains(item.id) ? !item.hasFocus : item.hasFocus;
  }
  DiagramList().resetRename();
  DiagramList().notify();
}

void unfocus() {
  List<DiagramType> items = DiagramList().items;
  for (DiagramType item in items) {
    item.hasFocus = false;
  }
  DiagramList().resetRename();
  DiagramList().notify();
}