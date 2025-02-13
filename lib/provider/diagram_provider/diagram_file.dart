import 'dart:developer';

class DiagramFile {
  /// File name (excluding path and extension)
  String? _name;

  /// File path (excluding name and extension)
  String? _path;

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  String? get path => _path;

  set path(String? value) {
    log('Setting path to $value');
    _path = value;
  }

  bool isSaved = true;
}
