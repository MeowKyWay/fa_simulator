library fa_simulator.globals;

import 'package:flutter/material.dart';

int stateCounter = 1;

//Text
const TextStyle textStyle = TextStyle(
  color: textColor,
  decoration: textDecoration,
  fontSize: textSize,
);
const double textSize = 20;
const Color textColor = Colors.black;
const TextDecoration textDecoration = TextDecoration.none;

//State
const double stateSize = 100;
const double stateFocusOverlayButtonSize = 15;
const Color stateBorderColor = Colors.black;
const Color stateBackgroundColor = Colors.white;

//Focus
const Color focusColor = Colors.blue;
// Coverage needed for selection area to focus on a state
const double coveragePercentage = 0.5;

//Body
const Size size = Size(7680, 4320);
const double gridSize = 50;
const double maxScale = 5.0;
const double minScale = 0.1;
