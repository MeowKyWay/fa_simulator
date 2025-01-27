import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/action/state/create_state_action.dart';
import 'package:fa_simulator/widget/body/inherited_widget/keyboard/keyboard_data.dart';
import 'package:fa_simulator/widget/body/inherited_widget/selection_data.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:flutter/material.dart';

class BodyGestureDetector extends StatefulWidget {
  final FocusNode focusNode;
  final Function(SelectionDetails) onSelectionUpdate;

  const BodyGestureDetector({
    super.key,
    required this.focusNode,
    required this.onSelectionUpdate,
  });

  @override
  State<BodyGestureDetector> createState() => _BodyGestureDetectorState();
}

class _BodyGestureDetectorState extends State<BodyGestureDetector> {
  Offset selectionStart = Offset.zero;
  Offset selectionCurrent = Offset.zero;
  bool isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: BodyProvider().gestureDetectorKey,
      // Unfocus the states on tap
      onTap: () {
        widget.focusNode.requestFocus();
        log(widget.focusNode.hasFocus.toString());
        AppActionDispatcher().execute(UnfocusAction());
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
        selectionStart = details.localPosition;
      },
      // Set current position for selection
      // Show the selection rectangle
      onPanUpdate: (DragUpdateDetails details) {
        selectionCurrent = details.localPosition;
        isSelecting = true;
        widget.onSelectionUpdate(SelectionDetails(
          start: selectionStart,
          current: selectionCurrent,
          isSelecting: isSelecting,
        ));
      },
      // Update the selection
      // Clear the selection rectangle
      onPanEnd: (DragEndDetails details) {
        isSelecting = false;
        _onSelectionEnd();
        widget.onSelectionUpdate(SelectionDetails(
          start: selectionStart,
          current: selectionCurrent,
          isSelecting: isSelecting,
        ));
      },
    );
  }

  void _onSelectionEnd() {
    Rect? rect = SelectionData.of(context)!.rect;
    if (rect == null) return;
    List<String> selectedItems = DiagramList()
        .items
        .where((item) => item.isContained(rect.topLeft, rect.bottomRight))
        .map((item) => item.id)
        .toList();

    log(KeyboardData.of(context)!.isShiftPressed.toString());
    // Request focus for the selected states
    if (KeyboardData.of(context)!.isShiftPressed) {
      AppActionDispatcher().execute(AddFocusAction(selectedItems));
      return;
    }
    AppActionDispatcher().execute(FocusAction(selectedItems));
  }
}
