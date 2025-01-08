import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

Widget acceptState({
  Widget? child,
  double stateSize = stateSize,
  required BuildContext context,
}) {
  ThemeData theme = Theme.of(context);

  // Todo resizable state
  return SizedBox(
    height: stateSize,
    width: stateSize,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: theme.colorScheme.tertiary,
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.onTertiary, width: 1)),
          child: child,
        ),
        IgnorePointer(
          child: Center(
            child: Container(
              height: stateSize - 15,
              width: stateSize - 15,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.onTertiary, width: 1),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
