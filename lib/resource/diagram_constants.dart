import 'dart:io';

class DiagramCharacter {
  static const String epsilon = 'ε';
  static const String emptySet = '∅';
  static const String sigma = 'Σ';
  static const String initial = 'q₀';
}

class DiagramPlatformConstant {
  static String fileSplitter = Platform.isMacOS ? '/' : '\\';
}
