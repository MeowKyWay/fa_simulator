import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

Widget startState({Widget? child, double stateSize = stateSize}) {
  // Todo resizable state
  return SizedBox(
    height: stateSize,
    width: stateSize,
    child: Container(
      decoration: BoxDecoration(
          color: stateBackgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: stateBorderColor, width: 1)),
      child: Center(
        // If renaming, show the text field
        child: Text(
          'Start',
          style: textXL,
        ),
      ),
    ),
  );
}
