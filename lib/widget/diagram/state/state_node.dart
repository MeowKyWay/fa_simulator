import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/toggle_focus_action.dart';
import 'package:fa_simulator/action/state/rename_state_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/state/state_focus_overlay.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/component/text.dart';
import 'package:fa_simulator/widget/diagram/state/state_rename_text_field.dart';
import 'package:flutter/material.dart';

class StateNode extends StatefulWidget {
  final DiagramState state;

  const StateNode({
    super.key,
    required this.state,
  });

  @override
  State<StateNode> createState() => _StateNodeState();
}

class _StateNodeState extends State<StateNode> {
  Offset pointerDownPosition = Offset.zero;
  bool pointerDownFlag = false;

  // Focus the state
  void _handleClick() {
    // If multiple select key is pressed, add state to the focus list
    if (KeyboardSingleton().pressedKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(AddFocusAction([widget.state.id]));
      return;
    }
    // Else request focus for the state
    AppActionDispatcher().execute(FocusAction([widget.state.id]));
  }

  void _focus() {
    if (KeyboardSingleton().pressedKeys.contains(multipleSelectKey)) {
      AppActionDispatcher().execute(ToggleFocusAction(widget.state.id));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _State newState;
    newState = _State(
      state: widget.state,
      isRenaming: StateList().renamingStateId == widget.state.id,
    );

    return Positioned(
      left: widget.state.position.dx - stateSize / 2,
      top: widget.state.position.dy - stateSize / 2,
      child: ClipOval(
        child: GestureDetector(
          onDoubleTap: () {
            StateList().startRename(widget.state.id);
          },
          child: Listener(
            onPointerDown: (event) {
              pointerDownPosition = event.localPosition;
              if (!widget.state.hasFocus) {
                _handleClick();
                pointerDownFlag = true;
              }
            },
            onPointerUp: (event) {
              if (pointerDownFlag) {
                pointerDownFlag = false;
                return;
              }
              if ((pointerDownPosition - event.localPosition).distance < 5) {
                _focus();
              }
            },
            child: newState,
          ),
        ),
      ),
    );
  }
}

class _State extends StatefulWidget {
  final DiagramState state;
  final bool isRenaming;

  // Diagram State constructor
  const _State({
    required this.state,
    required this.isRenaming,
  });

  @override
  State<_State> createState() {
    return _StateState();
  }
}

class _StateState extends State<_State> {
  String newName = '';
  late FocusNode _renameFocusNode;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_renameFocusNode.hasFocus) {
        AppActionDispatcher()
            .execute(RenameStateAction(widget.state.id, newName));
        KeyboardSingleton().focusNode.requestFocus();
      }
    };
    _renameFocusNode = FocusNode();
    _renameFocusNode.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _renameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRenaming) {
      // Request focus for the rename text field
      _renameFocusNode.requestFocus();
    }
    return GestureDetector(
      // Just to absorb the tap event
      child: SizedBox(
        height: stateSize,
        width: stateSize,
        child: Stack(
          children: [
            // The state
            Container(
              decoration: BoxDecoration(
                color: stateBackgroundColor,
                shape: BoxShape.circle,
                border: !widget.state.hasFocus
                    ? Border.all(color: stateBorderColor, width: 1.5)
                    : null,
              ),
              child: Center(
                // If renaming, show the text field
                child: widget.isRenaming
                    ? Padding(
                        padding: const EdgeInsets.all(5),
                        child: StateRenameTextField(
                            focusNode: _renameFocusNode,
                            stateName: widget.state.name,
                            onChanged: (value) => newName = value,
                            onSubmitted: (value) => _renameFocusNode.unfocus()),
                      )
                    : NormalText(text: widget.state.name),
              ),
            ),
            // Focus overlay
            if (widget.state.hasFocus) const StateFocusOverlay(),
            const DiagramDraggable(),
          ],
        ),
      ),
    );
  }
}
