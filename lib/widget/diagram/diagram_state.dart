import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/body.dart';
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
  late _DiagramStateWidget _state;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focus();
    _state = _DiagramStateWidget(
      size: stateSize,
      name: widget.name,
      color: Colors.white,
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
              feedback: _DiagramStateWidget(
                size: stateSize,
                color: Colors.white,
              ),
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

class _DiagramStateWidget extends StatelessWidget {
  final double size;
  final String name;
  final Color color;

  const _DiagramStateWidget(
      {this.size = 100, this.name = '', this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
