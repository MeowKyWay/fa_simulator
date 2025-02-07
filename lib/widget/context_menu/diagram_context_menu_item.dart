import 'package:fa_simulator/widget/context_menu/diagram_context_menu.dart';
import 'package:flutter/material.dart';

class DiagramContextMenuItem extends StatefulWidget {
  final String label;
  final void Function() onTap;
  final Color? color;

  const DiagramContextMenuItem({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  State<DiagramContextMenuItem> createState() => _DiagramContextMenuItemState();
}

class _DiagramContextMenuItemState extends State<DiagramContextMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          DiagramContextMenu.hide();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
