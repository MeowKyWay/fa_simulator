import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/action/state/create_state_action.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/selection_area_provider.dart';
import 'package:flutter/material.dart';

class BodyGestureDetector extends StatelessWidget {
  const BodyGestureDetector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: BodyProvider().gestureDetectorKey,
      // Unfocus the states on tap
      onTap: () {
        FocusScope.of(context).unfocus();
        AppActionDispatcher().execute(UnfocusAction());
        KeyboardProvider().focusNode.requestFocus();
      },
      // Add new state on double tap
      // Todo replace with drag the new state from menu
      onDoubleTapDown: (TapDownDetails details) {
        AppActionDispatcher().execute(CreateStateAction(
          position: details.localPosition,
          name: '',
        ));
      },
      // Set start position for selection
      onPanStart: (DragStartDetails details) {
        SelectionAreaProvider().setStart(details.localPosition);
      },
      // Set current position for selection
      // Show the selection rectangle
      onPanUpdate: (DragUpdateDetails details) {
        SelectionAreaProvider().setCurrent(details.localPosition);
        SelectionAreaProvider().isSelecting = true;
      },
      // Update the selection
      // Clear the selection rectangle
      onPanEnd: (DragEndDetails details) {
        SelectionAreaProvider().updateSelection();
        SelectionAreaProvider().isSelecting = false;
      },
    );
  }
}
