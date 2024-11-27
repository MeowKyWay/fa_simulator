import 'package:flutter/material.dart';

class NewTransitionButtonSingleton {
  //Singleton
  static final NewTransitionButtonSingleton _instance = NewTransitionButtonSingleton._internal();
  factory NewTransitionButtonSingleton() => _instance;
  NewTransitionButtonSingleton._internal();

  bool isHovering = false;
  Offset? position;
}