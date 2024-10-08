import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';


Widget state({Widget? child}) {
  // Todo resizable state
  return SizedBox(
    height: stateSize,
    width: stateSize,
    child: Container(
      decoration: BoxDecoration(
          color: stateBackgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: stateBorderColor, width: 1)),
      child: child,
    ),
  );
}