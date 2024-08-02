import 'dart:developer';

import 'package:fa_simulator/widget/diagram/dragable.dart';
import 'package:fa_simulator/widget/diagram/focus_overlay.dart';
import 'package:flutter/material.dart';

class DiagramState extends StatefulWidget {
  final double size;
  final Offset position;
  final String name;

  final Function(String) onRemove;

  const DiagramState({
    super.key,
    this.size = 100,
    required this.position,
    required this.name,
    required this.onRemove,
  });

  @override
  State<DiagramState> createState() {
    return _DiagramStateState();
  }
}

class _DiagramStateState extends State<DiagramState> {
  late FocusNode _focusNode;

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

  @override
  Widget build(BuildContext context) {
    return Dragable(
      left: widget.position.dx - widget.size / 2,
      top: widget.position.dy - widget.size / 2,
      focus: _focus,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: FocusOverlay(
          hasFocus: _focusNode.hasFocus,
          child: ClipOval(
              child: Focus(
                focusNode: _focusNode,
                onFocusChange: (hasFocus) {
                  setState(() {
                    if (hasFocus) {
                      log('Focused on ${widget.name}');
                    }
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    // Notify when the widget is tapped
                    _focus();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(widget.name),
                    ),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
