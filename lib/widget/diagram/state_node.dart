import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/action/action.dart';
import 'package:fa_simulator/action/action_dispatcher.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/component/text.dart';
import 'package:flutter/material.dart';

class StateNode extends StatelessWidget {
  final DiagramState state;

  const StateNode({
    super.key,
    required this.state,
  });

  // Focus the state
  void _focus() {
    // If multiple select key is pressed, add state to the focus list
    if (KeyboardSingleton().pressedKeys.contains(multipleSelect)) {
      StateList().addFocus(state.id);
      return;
    }
    // Else request focus for the state
    StateList().requestFocus(state.id);
  }

  @override
  Widget build(BuildContext context) {
    _DiagramState newState;
    newState = _DiagramState(
      state: state,
      isRenaming: StateList().renamingStateId == state.id,
    );

    return Positioned(
      left: state.position.dx - stateSize / 2,
      top: state.position.dy - stateSize / 2,
      child: ClipOval(
        child: GestureDetector(
          onTap: () {
            _focus();
          },
          child: newState,
        ),
      ),
    );
  }
}

class _DiagramState extends StatefulWidget {
  final DiagramState state;
  final bool isRenaming;

  // Diagram State constructor
  const _DiagramState({
    required this.state,
    required this.isRenaming,
  });

  @override
  State<_DiagramState> createState() {
    return _DiagramStateState();
  }
}

class _DiagramStateState extends State<_DiagramState> {
  String newName = '';
  bool isHovered = false;
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
      // Unfocus the keyboard listenner
      // Request focus for the rename text field
      _renameFocusNode.requestFocus();
    }
    return MouseRegion(
      onEnter: (event) {
        // Set the state status to hovered
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        // Set the state status to not hovered
        setState(() {
          isHovered = false;
        });
      },
      // Change mouse icon to grab when hovered
      cursor: SystemMouseCursors.grab,
      child: SizedBox(
        height: stateSize,
        width: stateSize,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: stateBackgroundColor,
                shape: BoxShape.circle,
                border: !widget.state.hasFocus
                    ? Border.all(color: stateBorderColor)
                    : null,
              ),
              child: Center(
                child: widget.isRenaming
                    ? Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          focusNode: _renameFocusNode,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: textSize,
                            decoration: textDecoration,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            newName = value;
                          },
                          onSubmitted: (value) {
                            AppActionDispatcher().execute(
                                RenameStateAction(widget.state.id, newName));
                            KeyboardSingleton().focusNode.requestFocus();
                          },
                        ),
                      )
                    : NormalText(text: widget.state.name),
              ),
            ),
            if (widget.state.hasFocus)
              DottedBorder(
                  padding: const EdgeInsets.all(0.5),
                  borderType: BorderType.Oval,
                  dashPattern: const [5, 2.5],
                  strokeWidth: 1.5,
                  color: focusColor,
                  child: Container()),
          ],
        ),
      ),
    );
  }
}
