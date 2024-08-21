import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/diagram/draggable_widget.dart';
import 'package:fa_simulator/widget/diagram/overlay/focus_overlay.dart';
import 'package:fa_simulator/widget/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiagramStateWidget extends StatefulWidget {
  final DiagramState state;

  const DiagramStateWidget({
    super.key,
    required this.state,
  });

  @override
  State<DiagramStateWidget> createState() {
    return _DiagramStateWidgetState();
  }
}

class _DiagramStateWidgetState extends State<DiagramStateWidget> {

  late _DiagramState _state;
  bool isRenaming = false;

  @override void initState() {
    super.initState();
  }

  void _focus() {
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

    Offset margin = widget.state.hasFocus ? -const Offset(7.5, 7.5) : Offset.zero;

    return Positioned(
      left: widget.state.position.dx + margin.dx,
      top: widget.state.position.dy + margin.dy,
      child: FocusOverlay(
        hasFocus: widget.state.hasFocus,
        onDelete: () => StateList().deleteState(widget.state.id),
        scale: scale,
        child: DraggableState(
          state: widget.state,
          margin: margin,
          scale: scale,
          feedback: _state,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _focus();
              });
              StateList().states.forEach((element) {
                log(element.name);
              });
            },
            child: _state,
          ),
        ),
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
        child: Container(
          decoration: BoxDecoration(
            color: stateBackgroundColor,
            border: Border.all(
              color: isHovered
                  ? focusColor
                  : widget.state.hasFocus
                      ? focusColor
                      : stateBorderColor,
              width: 1,
            ),
            shape: BoxShape.circle,
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
      ),
    );
  }
}
