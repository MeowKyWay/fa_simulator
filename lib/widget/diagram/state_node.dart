import 'package:dotted_border/dotted_border.dart';
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
      left: state.position.dx,
      top: state.position.dy,
      child: GestureDetector(
        onTap: () {
          _focus();
        },
        child: newState,
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
  bool isHovered = false;
  final FocusNode _renameFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _renameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRenaming) {
      // Request focus for the rename text field
      FocusScope.of(context).requestFocus(_renameFocusNode);
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
                            StateList().renameState(widget.state.id, value);
                          },
                          onSubmitted: (value) {
                            StateList().endRename();
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
