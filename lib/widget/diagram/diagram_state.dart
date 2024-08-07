import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/draggable_widget.dart';
import 'package:fa_simulator/widget/diagram/overlay/focus_overlay.dart';
import 'package:flutter/material.dart';

class DiagramStateWidget extends StatefulWidget {
  final Offset position;
  final String name;
  final Function(Offset) onDragEnd;

  final VoidCallback onDelete;

  const DiagramStateWidget({
    super.key,
    required this.position,
    required this.name,
    required this.onDragEnd,
    required this.onDelete,
  });

  @override
  State<DiagramStateWidget> createState() {
    return _DiagramStateWidgetState();
  }
}

class _DiagramStateWidgetState extends State<DiagramStateWidget> {
  late FocusNode _focusNode;
  late _DiagramState _state;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focus();
    _state = _DiagramState(
      name: widget.name,
      focusNode: _focusNode,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _focus() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableWidget(
        position: widget.position,
        margin: _focusNode.hasFocus ? -const Offset(7.5, 7.5) : Offset.zero,
        onDragEnd: widget.onDragEnd,
        scale: scale,
        focusNode: _focusNode,
        feedback: _state,
        child: Focus(
          focusNode: _focusNode,
          onFocusChange: (hasFocus) {
            setState(() {});
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
              //onDragEnd: widget.onDragEnd,
              scale: scale,
              child: _state,
            ),
          ),
        ));
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

  const _DiagramState({
    this.name = '',
    required this.focusNode,
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
            child: Text(
              widget.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
