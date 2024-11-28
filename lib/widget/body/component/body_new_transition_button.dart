import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_button.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyNewTransitionButton extends StatelessWidget {
  const BodyNewTransitionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTransitionProvider>(builder: (context, provider, child) {
      Offset? position;
      bool flag = false;
      if (provider.destinationPosition != null &&
          !provider.destinationStateCentered) {
        position = provider.destinationPosition;
        flag = true;
      } // currently at the edge of the destination state
      position = position ?? provider.buttonPosition;
      return Consumer<KeyboardProvider>(
        builder: (context, keyboardProvider, child) {
          return position != null && (keyboardProvider.isShiftPressed || flag)
              ? NewTransitionButton(position: position)
              : Container();
        }
      );
    });
  }
}
