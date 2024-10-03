import 'package:fa_simulator/widget/diagram/diagram_type.dart';

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

  void copy(List<DiagramType> items) {
    _items.clear();
    _items.addAll(items);
  }
}

