import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/diagram/draggable_widget.dart';
import 'package:fa_simulator/widget/diagram/focus_overlay.dart';
import 'package:flutter/material.dart';

class DiagramStateWidget extends StatefulWidget {
  final double size;
  final Offset position;
  final String name;
  final Function(Offset) onDragEnd;

  final VoidCallback onDelete;

  const DiagramStateWidget({
    super.key,
    this.size = 100,
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
    return DraggableWidget(
        position: Offset(widget.position.dx, widget.position.dy),
        margin: Offset(-(widget.size / 2), -(widget.size / 2)),
        feedback: _DiagramStateWidget(
          size: widget.size,
          color: const Color.fromARGB(200, 255, 255, 255),
        ),
        onDragEnd: widget.onDragEnd,
        scale: scale,
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
              child: _DiagramStateWidget(
                size: widget.size,
                name: widget.name,
                color: Colors.white,
              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
