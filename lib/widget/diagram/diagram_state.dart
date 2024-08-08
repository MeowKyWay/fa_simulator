import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/diagram/draggable_widget.dart';
import 'package:fa_simulator/widget/diagram/overlay/focus_overlay.dart';
import 'package:fa_simulator/widget/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiagramStateWidget extends StatefulWidget {
  final Offset position;
  final String name;
  final Function(Offset) onDragEnd;

  final VoidCallback onDelete;
  final Function(String) onRename;

  const DiagramStateWidget({
    super.key,
    required this.position,
    required this.name,
    required this.onDragEnd,
    required this.onDelete,
    required this.onRename,
  });

  @override
  State<DiagramStateWidget> createState() {
    return _DiagramStateWidgetState();
  }
}

class _DiagramStateWidgetState extends State<DiagramStateWidget> {
  late FocusNode _focusNode;
  late _DiagramState _state;

  bool isRenaming = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _focus() {
    _focusNode.requestFocus();
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
      name: widget.name,
      focusNode: _focusNode,
      onRename: widget.onRename,
      isRenaming: isRenaming,
      setIsRenaming: _setIsRenaming,
    );
    return DraggableWidget(
      position: widget.position,
      margin: _focusNode.hasFocus ? -const Offset(7.5, 7.5) : Offset.zero,
      onDragEnd: widget.onDragEnd,
      scale: scale,
      focusNode: _focusNode,
      feedback: _state,
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _onKeyEvent,
        onFocusChange: (hasFocus) {
          setState(() {
            if (!hasFocus) {
              isRenaming = false;
            }
          });
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              _focus();
            });
          },
          child: FocusOverlay(
            hasFocus: _focusNode.hasFocus,
            onDelete: widget.onDelete,
            scale: scale,
            child: _state,
          ),
        ),
      ),
    );
  }
}

class DiagramState {
  Offset position;
  String name;

  DiagramState({
    required this.position,
    required this.name,
  });
}

class _DiagramState extends StatefulWidget {
  final String name;
  final FocusNode focusNode;
  final bool isRenaming;
  final Function(String) onRename;
  final Function(bool) setIsRenaming;

  const _DiagramState({
    this.name = '',
    required this.focusNode,
    required this.isRenaming,
    required this.onRename,
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
                  : widget.focusNode.hasFocus
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
                        log('onSubmitted');
                        widget.onRename(value);
                        // widget.setIsRenaming(false);
                        widget.focusNode.requestFocus();
                      },
                    ),
                  )
                : NormalText(text: widget.name),
          ),
        ),
      ),
    );
  }
}
