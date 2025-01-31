import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/toggle_focus_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/inherited_widget/keyboard/keyboard_data.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/state/state_drag_target.dart';
import 'package:fa_simulator/widget/diagram/state/hover_overlay/state_hover_overlay.dart';
import 'package:fa_simulator/widget/diagram/state/node/state_node.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

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
  Offset _pointerDownPosition = Offset.zero;
  bool _pointerDownFlag = false;

  @override
  Widget build(BuildContext context) {
    StateNode newState;
    newState = StateNode(
      state: widget.state,
      isRenaming: RenamingProvider().renamingItemId == widget.state.id,
    );

    return Positioned(
      left:
          widget.state.position.dx - stateSize / 2 - stateFocusOverlayRingWidth,
      top:
          widget.state.position.dy - stateSize / 2 - stateFocusOverlayRingWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: StateDragTarget(
              state: widget.state,
              child: GestureDetector(
                onDoubleTap: _handleDoubleTap,
                child: Listener(
                  onPointerDown: (event) {
                    _pointerDownPosition = event.localPosition;
                    if (!widget.state.hasFocus) {
                      // Prevent group dragging to only focus the state when drag start
                      _handleClick();
                      _pointerDownFlag = true;
                    }
                  },
                  onPointerUp: (event) {
                    if (_pointerDownFlag) {
                      _pointerDownFlag = false;
                      return;
                    }
                    if ((_pointerDownPosition - event.localPosition).distance <
                        5) {
                      // If the pointer moved less than 5 pixels, focus the state
                      _handleClick();
                      _focus();
                    }
                  },
                  child: Stack(children: [
                    Container(
                      padding: EdgeInsets.all(stateFocusOverlayRingWidth),
                      color: Colors.transparent,
                      width: stateSize + stateFocusOverlayRingWidth * 2,
                      height: stateSize + stateFocusOverlayRingWidth * 2,
                      child: Center(child: newState),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          StateHoverOverlay(state: widget.state),
        ],
      ),
    );
  }

  // Focus the state
  void _handleClick() {
    // If multiple select key is pressed, add state to the focus list
    if (KeyboardData.of(context)!.isShiftPressed) {
      AppActionDispatcher().execute(AddFocusAction([widget.state.id]));
      return;
    }
    // Else request focus for the state
    AppActionDispatcher().execute(FocusAction([widget.state.id]));
  }

  void _handleDoubleTap() {
    AppActionDispatcher().execute(FocusAction([widget.state.id]));
    RenamingProvider().startRename(id: widget.state.id);
  }

  void _focus() {
    if (KeyboardData.of(context)!.isShiftPressed) {
      AppActionDispatcher().execute(ToggleFocusAction([widget.state.id]));
      return;
    }
  }
}
