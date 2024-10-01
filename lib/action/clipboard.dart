import 'package:fa_simulator/widget/diagram/diagram_type.dart';

class DiagramClipboard {
  static final DiagramClipboard _instance = DiagramClipboard._internal();
  DiagramClipboard._internal();
  factory DiagramClipboard() {
    return _instance;
  }

  final List<DiagramType> _items = [];

  List<DiagramType> get items => _items;

  void copy(List<DiagramType> items) {
    _items.clear();
    _items.addAll(items);
  }
}

