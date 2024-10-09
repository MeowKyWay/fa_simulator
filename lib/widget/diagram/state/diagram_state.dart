import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/toggle_focus_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/state/node/state_node.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiagramState extends StatefulWidget {
  final StateType state;

  const DiagramState({
    super.key,
    required this.state,
  });

  @override
  State<DiagramState> createState() => _DiagramStateState();
}

class _DiagramStateState extends State<DiagramState> {
  Offset pointerDownPosition = Offset.zero;
  bool pointerDownFlag = false;
  bool isHovered = false;

  // Focus the state
  void _handleClick() {
    // If multiple select key is pressed, add state to the focus list
    if (KeyboardSingleton().modifierKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(AddFocusAction([widget.state.id]));
      return;
    }
    // Else request focus for the state
    AppActionDispatcher().execute(FocusAction([widget.state.id]));
  }

  void _handleDoubleTap() {
    AppActionDispatcher().execute(FocusAction([widget.state.id]));
    DiagramList().startRename(widget.state.id);
  }

  void _focus() {
    if (KeyboardSingleton().modifierKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(ToggleFocusAction([widget.state.id]));
      return;
    }
  }

  void _onMouseEnter(PointerEnterEvent event) {
    setState(() {
      isHovered = true;
    });
  }

  void _onMouseExit(PointerExitEvent event) {
    setState(() {
      isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    StateNode newState;
    newState = StateNode(
      state: widget.state,
      isRenaming: DiagramList().renamingItemId == widget.state.id,
    );

    return Positioned(
      left: widget.state.position.dx - stateSize / 2,
      top: widget.state.position.dy - stateSize / 2,
      child: ClipOval(
        child: GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.move,
            onEnter: _onMouseEnter,
            onExit: _onMouseExit,
            child: Listener(
              onPointerDown: (event) {
                pointerDownPosition = event.localPosition;
                if (!widget.state.hasFocus) {
                  // Prevent group dragging to only focus the state when drag start
                  _handleClick();
                  pointerDownFlag = true;
                }
              },
              onPointerUp: (event) {
                if (pointerDownFlag) {
                  pointerDownFlag = false;
                  return;
                }
                if ((pointerDownPosition - event.localPosition).distance <
                    5) {
                  // If the pointer moved less than 5 pixels, focus the state
                  _handleClick();
                  _focus();
                }
              },
              child: newState,
            ),
          ),
        ),
      ),
    );
  }
}
