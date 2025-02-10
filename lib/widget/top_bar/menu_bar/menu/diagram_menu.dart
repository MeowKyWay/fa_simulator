import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_context_menu_region.dart';
import 'package:flutter/material.dart';

abstract class DiagramMenu extends StatefulWidget {
  final bool isOpen;
  final Function() close;

  const DiagramMenu({
    super.key,
    required this.isOpen,
    required this.close,
  });

  String get label;

  List<Widget> items(BuildContext context);

  EdgeInsets get padding => EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  @override
  State<DiagramMenu> createState() => _DiagramMenuState();
}

class _DiagramMenuState extends State<DiagramMenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DiagramMenuContextMenuRegion(
      isOpen: widget.isOpen,
      onClose: widget.close,
      onEnter: () {
        setState(() {
          isHovered = true;
        });
      },
      onExit: () {
        setState(() {
          isHovered = false;
        });
      },
      items: widget.items(context),
      child: Container(
        color: isHovered ? theme.colorScheme.surface : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              widget.label,
              style: textM.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
