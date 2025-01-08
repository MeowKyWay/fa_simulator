import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/foundation.dart';

class FileProvider extends DiagramProvider with ChangeNotifier {
  // Singleton
  static final FileProvider _instance = FileProvider._internal();
  factory FileProvider() => _instance;
  FileProvider._internal();

  String? _fileName;
  String? _filePath;
  FAType? _faType;
  List<DiagramType> _savedItem = [];

  String? get fileName => _fileName;
  String? get filePath => _filePath;
  FAType? get faType => _faType;
  List<DiagramType> get savedItem => _savedItem;

  set fileName(String? value) {
    _fileName = value;
    notifyListeners();
  }

  set filePath(String? value) {
    _filePath = value;
    notifyListeners();
  }

  set faType(FAType? value) {
    _faType = value;
    notifyListeners();
  }

  set savedItem(List<DiagramType> value) {
    _savedItem = value;
    notifyListeners();
    DiagramList().notify();
  }

  bool get isSaved => listEquals(savedItem, DiagramList().items);

  @override
  void reset() {
    _fileName = null;
    _filePath = null;
    _faType = null;
    _savedItem = [];
    notifyListeners();
  }
}
