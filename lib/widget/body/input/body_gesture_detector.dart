
import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/action/state/create_state_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
import 'package:flutter/material.dart';

class BodyGestureDetector extends StatelessWidget {
  const BodyGestureDetector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: BodySingleton().getGestureDetectorKey,
      // Unfocus the states on tap
      onTap: () {
        AppActionDispatcher().execute(UnfocusAction());
      },
      // Add new state on double tap
      // Todo replace with drag the new state from menu
      onDoubleTapDown: (TapDownDetails details) {
        AppActionDispatcher()
            .execute(CreateStateAction(details.localPosition, ''));
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
        SelectionAreaProvider()._updateSelection();
        SelectionAreaProvider().isSelecting = false;
      },
    );
  }
}

class SelectionAreaProvider with ChangeNotifier {
  static final SelectionAreaProvider _instance =
      SelectionAreaProvider._internal();
  SelectionAreaProvider._internal();
  factory SelectionAreaProvider() => _instance;

  Offset _start = Offset.zero;
  Offset _current = Offset.zero;
  bool _isSelecting = false;

  void setStart(Offset start) {
    _start = start;
    notifyListeners();
  }

  void setCurrent(Offset current) {
    _current = current;
    notifyListeners();
  }

  Offset get start => _start;
  Offset get current => _current;
  bool get isSelecting => _isSelecting;
  set isSelecting(bool value) {
    _isSelecting = value;
    notifyListeners();
  }

  Rect? get rect {
    // Return null if not selecting
    if (!_isSelecting) return null;

    double left = _start.dx;
    double top = _start.dy;
    double right = current.dx;
    double bottom = current.dy;

    // Return the rectangle and determine the top-left and bottom-right corners
    return Rect.fromLTRB(
      left < right ? left : right,
      top < bottom ? top : bottom,
      left < right ? right : left,
      top < bottom ? bottom : top,
    );
  }

  void _updateSelection() {
    // Get the selected states
    List<String> selectedStates = StateList()
        .states
        .where((state) => _isOverlapping(state))
        .map((state) => state.id)
        .toList();

    // Request focus for the selected states
    if (KeyboardSingleton().pressedKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(AddFocusAction(selectedStates));
      return;
    }
    AppActionDispatcher().execute(FocusAction(selectedStates));
  }

  bool _isOverlapping(DiagramState state) {
    // Check if the selection rectangle is available
    if (this.rect == null) return false;
    Rect rect = this.rect!;

    // Get the size of the DiagramState
    double stateLeft = state.position.dx - (stateSize / 2);
    double stateRight = state.position.dx + (stateSize / 2);
    double stateTop = state.position.dy - (stateSize / 2);
    double stateBottom = state.position.dy + (stateSize / 2);

    Rect stateRect =
        Rect.fromLTRB(stateLeft, stateTop, stateRight, stateBottom);

    // Calculate the intersection area between the state and the selection rectangle
    Rect intersection = rect.intersect(stateRect);

    // If there is no intersection, return false
    if (intersection.isEmpty) {
      return false;
    }

    // Calculate the area of the intersection
    double intersectionArea = intersection.width * intersection.height;

    // Calculate the total area of the DiagramState
    double stateArea = stateSize * stateSize;

    // Calculate the coverage percentage
    double coverage = intersectionArea / stateArea;

    // Return true if the coverage is at least 80%
    return coverage >= coveragePercentage;
  }
}
