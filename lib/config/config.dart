library fa_simulator.globals;

import 'package:flutter/material.dart';

int stateCounter = 1;

//State
const double stateSize = 100;
const double stateFocusOverlayButtonSize = 15;

//Focus
const Color focusColor = Colors.blue;
// Coverage needed for selection area to focus on a state
const double coveragePercentage = 0.5;

//Body
const Size bodySize = Size(7680, 4320);
const double gridSize = 50;
const int subGridCount = 4;
const double maxScale = 5.0;
const double minScale = 0.1;
