import 'package:flutter/material.dart';

class DraggingProvider {
  //Singleton
  static final DraggingProvider _instance = DraggingProvider._internal();
  DraggingProvider._internal();
  factory DraggingProvider() {
    return _instance;
  }

  Offset? startPosition;
  Offset? endPosition;

  Offset get deltaOffset {
    if (startPosition == null || endPosition == null) {
      return Offset.zero;
    }
    return endPosition! - startPosition!;
  }

  void reset() {
    startPosition = null;
    endPosition = null;
  }
}