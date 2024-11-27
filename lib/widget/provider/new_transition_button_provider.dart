import 'package:flutter/material.dart';

class NewTransitionButtonProvider with ChangeNotifier {
  //Singleton
  static final NewTransitionButtonProvider _instance = NewTransitionButtonProvider._internal();
  factory NewTransitionButtonProvider() => _instance;
  NewTransitionButtonProvider._internal();

  bool isHovering = false;
  Offset? position;
}