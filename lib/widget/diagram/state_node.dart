import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/control.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/component/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StateNode extends StatefulWidget {
  final DiagramState state;

  const StateNode({
    super.key,
    required this.state,
  });

  @override
  State<StateNode> createState() {
    return _StateNodeState();
  }
}

class _StateNodeState extends State<StateNode> {
  late _DiagramState _state;
  bool isRenaming = false;

  @override
  void initState() {
    super.initState();
  }

  void _focus() {
    if (KeyboardSingleton().pressedKeys.contains(multipleSelect)) {
      //Move to control config
      StateList().addFocus(widget.state.id);
      return;
    }
    StateList().requestFocus(widget.state.id);
  }

  KeyEventResult _onKeyEvent(FocusNode focusNode, KeyEvent event) {
    if (event is KeyDownEvent) return KeyEventResult.ignored;
    if (isRenaming) return KeyEventResult.ignored;
    if (!focusNode.hasFocus) return KeyEventResult.ignored;
    if (event.logicalKey != LogicalKeyboardKey.enter) {
      return KeyEventResult.ignored;
    }
    setState(() {
      isRenaming = true;
    });
    return KeyEventResult.handled;
  }

  void _setIsRenaming(bool value) {
    setState(() {
      isRenaming = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _state = _DiagramState(
      state: widget.state,
      isRenaming: isRenaming,
      setIsRenaming: _setIsRenaming,
    );

    return Positioned(
      left: widget.state.position.dx,
      top: widget.state.position.dy,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _focus();
          });
        },
        child: _state,
      ),
    );
  }
}

class _DiagramState extends StatefulWidget {
  final DiagramState state;
  final bool isRenaming;
  final Function(bool) setIsRenaming;

  const _DiagramState({
    required this.state,
    required this.isRenaming,
    required this.setIsRenaming,
  });

  @override
  State<_DiagramState> createState() {
    return _DiagramStateState();
  }
}

class _DiagramStateState extends State<_DiagramState> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
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
                          onSubmitted: (value) {
                            StateList().renameState(widget.state.id, value);
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
