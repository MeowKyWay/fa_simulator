import 'dart:io';

class DiagramShortcut {
  String get control {
    if (Platform.isMacOS) {
      return 'Cmd';
    }
    return 'Ctrl';
  }

  //file
  String get newFile => '$control + N';
  String get open => '$control + O';

  String get save => '$control + S';
  String get saveAs => '$control + Shift + S';

  //edit
  String get undo => '$control + Z';
  String get redo => '$control + Shift + Z';

  String get cut => '$control + X';
  String get copy => '$control + C';
  String get paste => '$control + V';

  String get selectAll => '$control + A';
  String get selectNone => '$control + Shift + A';
}
