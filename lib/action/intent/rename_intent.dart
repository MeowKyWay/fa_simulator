import 'package:flutter/material.dart';

class RenameIntent extends Intent {
  final String initialName;

  const RenameIntent({
    this.initialName = '',
  });
}
