import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

Widget state({
  Widget? child,
  double stateSize = stateSize,
  bool isAcceptState = false,
  required BuildContext context,
}) {
  ThemeData theme = Theme.of(context);
  return SizedBox(
    height: stateSize,
    width: stateSize,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
              //White border
              border: Border.all(color: theme.colorScheme.outline, width: 1)),
          child: child,
        ),
        isAcceptState
            ? IgnorePointer(
                child: Center(
                  child: Container(
                    height: stateSize - 15,
                    width: stateSize - 15,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: theme.colorScheme.onPrimary, width: 1),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}
