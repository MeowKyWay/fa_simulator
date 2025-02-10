import 'package:fa_simulator/widget/context_menu/diagram_context_menu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiagramContextMenuItem extends StatefulWidget {
  final String label;
  final String shortcut;
  final void Function() onTap;
  final Color? color;
  final EdgeInsets? padding;
  final bool enabled;

  const DiagramContextMenuItem({
    super.key,
    required this.label,
    this.shortcut = '',
    required this.onTap,
    this.color,
    this.padding,
    this.enabled = true,
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
        if (!widget.enabled) return;
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        if (!widget.enabled) return;
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          if (!widget.enabled) return;
          widget.onTap();
          DiagramContextMenu.hide();
        },
        child: Container(
          padding: widget.padding ??
              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.enabled
                      ? widget.color
                      : Theme.of(context).colorScheme.onTertiary,
                ),
              ),
              Gap(50),
              Spacer(),
              Text(
                widget.shortcut,
                style: TextStyle(
                  color: widget.enabled
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
