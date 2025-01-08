import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';


Widget state({Widget? child, double stateSize = stateSize, required BuildContext context}) {
  ThemeData theme = Theme.of(context);
  // Todo resizable state
  return SizedBox(
    height: stateSize,
    width: stateSize,
    child: Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.onTertiary, width: 1)),
      child: child,
    ),
  );
}