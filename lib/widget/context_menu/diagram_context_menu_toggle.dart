import 'package:flutter/material.dart';

class DiagramContextMenuToggle extends StatefulWidget {
  final String label;
  final Color? color;
  final bool value;
  final void Function(bool) onChanged;

  const DiagramContextMenuToggle({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
    this.color,
  });

  @override
  State<DiagramContextMenuToggle> createState() =>
      _DiagramContextMenuToggleState();
}

class _DiagramContextMenuToggleState extends State<DiagramContextMenuToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: MouseRegion(
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
              Spacer(),
              Icon(
                widget.value ? Icons.check_box : Icons.check_box_outline_blank,
                color: widget.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
