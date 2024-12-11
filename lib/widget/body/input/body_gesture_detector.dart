import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/action/state/create_state_action.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
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
    if (rect == null) return;
    List<String> selectedItems = DiagramList()
        .items
        .where((item) => item.isContained(rect!.topLeft, rect!.bottomRight))
        .map((item) => item.id)
        .toList();

    // Request focus for the selected states
    if (KeyboardProvider().modifierKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(AddFocusAction(selectedItems));
      return;
    }
    AppActionDispatcher().execute(FocusAction(selectedItems));
  }
}
