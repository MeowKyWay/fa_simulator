library;

import 'package:flutter/material.dart';

int stateCounter = 1;

//State
const double stateSize = 100;
const double stateFocusOverlayButtonSize = 15;
const double stateFocusOverlayRingWidth = 7.5;

//Transition
const double transitionLineWidth = 1.0;
const Color transitionLineColor = Colors.white;

// Coverage needed for selection area to focus on a state
const double coveragePercentage = 0.5;

//Body
const Size bodySize = Size(7680, 4320);
const double gridSize = 50;
const int subGridCount = 4;
const double subGridSize = gridSize / subGridCount;
const double maxScale = 5.0;
const double minScale = 0.15;
