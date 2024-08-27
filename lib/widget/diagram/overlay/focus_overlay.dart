import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/diagram/overlay/delete_button.dart';
import 'package:flutter/material.dart';

//Unuses

class FocusOverlay extends StatelessWidget {
  final DiagramState state;
  final Widget child;
  final double scale;

  const FocusOverlay({
    super.key,
    required this.state,
    required this.child,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    if (state.hasFocus) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: DottedBorder(
              padding: const EdgeInsets.all(0),
              borderType: BorderType.Oval,
              dashPattern: const [10, 5],
              color: focusColor,
              child: child,
            ),
          ),
        ],
      );
    }
    return child;
  }
}
