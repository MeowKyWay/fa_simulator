import 'package:fa_simulator/widget/context_menu/diagram_context_menu.dart';
import 'package:flutter/material.dart';

class DiagramMenuContextMenuRegion extends StatefulWidget {
  final Widget child;
  final Function() onEnter;
  final Function() onExit;
  final List<Widget> items;
  final bool isOpen;

  const DiagramMenuContextMenuRegion({
    super.key,
    required this.child,
    required this.onEnter,
    required this.onExit,
    required this.items,
    required this.isOpen,
  });

  @override
  State<DiagramMenuContextMenuRegion> createState() =>
      _DiagramMenuContextMenuRegionState();
}

class _DiagramMenuContextMenuRegionState
    extends State<DiagramMenuContextMenuRegion> {
  final GlobalKey _key = GlobalKey();
  bool _isHovered = false;

  void _showContextMenu(BuildContext context) {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
    final Size widgetSize = renderBox.size;

    // Calculate bottom-left corner position
    final Offset bottomLeft =
        Offset(widgetPosition.dx, widgetPosition.dy + widgetSize.height);

    DiagramContextMenu.show(
      context: context,
      position: bottomLeft,
      menu: widget.items,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isOpen && _isHovered) _showContextMenu(context);
    });
    return MouseRegion(
      key: _key,
      onEnter: (event) {
        widget.onEnter();
        _isHovered = true;
        if (widget.isOpen) _showContextMenu(context);
      },
      onExit: (event) {
        widget.onExit();
        _isHovered = false;
      },
      child: widget.child,
    );
  }
}
