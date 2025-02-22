import 'package:flutter/material.dart';

class DiagramPanelMenuItem extends StatefulWidget {
  final String label;
  final Function() onTap;
  final bool isActive;
  final int? number;

  const DiagramPanelMenuItem({
    super.key,
    required this.label,
    required this.onTap,
    required this.isActive,
    this.number,
  });

  @override
  State<DiagramPanelMenuItem> createState() => _DiagramPanelMenuItemState();
}

class _DiagramPanelMenuItemState extends State<DiagramPanelMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          onTap: widget.onTap,
          child: Container(
            height: 20,
            padding: EdgeInsets.fromLTRB(2, 0, 2, widget.isActive ? 1 : 2),
            decoration: BoxDecoration(
              border: widget.isActive
                  ? Border(
                      bottom: BorderSide(
                          color: Theme.of(context).focusColor, width: 1))
                  : null,
            ),
            child: Row(
              spacing: 5,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: widget.isActive || _isHovered
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                if (widget.number != null && widget.number! > 0)
                  CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      widget.number!.toString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  )
              ],
            ),
          )),
    );
  }
}
