import 'package:flutter/material.dart';

class DiagramPanelDragBar extends StatefulWidget {
  final Function(double) onChange;
  final double maxHeight;
  final double minHeight;

  const DiagramPanelDragBar({
    super.key,
    required this.onChange,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  State<DiagramPanelDragBar> createState() => _DiagramPanelDragBarState();
}

class _DiagramPanelDragBarState extends State<DiagramPanelDragBar> {
  bool _isHovered = false;
  bool _isDragging = false;

  get isHovered => _isHovered || _isDragging;

  void onDragUpdate(DragUpdateDetails details) {
    widget.onChange(details.primaryDelta!);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRow,
      onEnter: (event) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
        });
      },
      child: SizedBox(
        height: widget.maxHeight,
        width: double.infinity,
        child: GestureDetector(
          onVerticalDragUpdate: onDragUpdate,
          onVerticalDragStart: (_) {
            setState(() {
              _isDragging = true;
            });
          },
          onVerticalDragEnd: (_) {
            setState(() {
              _isDragging = false;
            });
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: isHovered ? widget.maxHeight : widget.minHeight,
              color: isHovered
                  ? Theme.of(context).focusColor
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
      ),
    );
  }
}
