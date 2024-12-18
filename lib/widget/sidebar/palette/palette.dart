import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/sidebar/sidebar_row.dart';
import 'package:flutter/material.dart';

class Palette extends StatefulWidget {
  //TODO prevent feedback showing when dragging outside the body
  final String label;
  final Widget child;

  const Palette({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  State<Palette> createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: SidebarRow(
            child: Row(
              children: [
                Icon(
                  (_isExpanded) ? Icons.expand_more : Icons.expand_less,
                  color: primaryTextColor,
                  size: textMediumSize,
                ),
                Text(
                  widget.label,
                  style: textM,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) SidebarRow(child: widget.child),
      ],
    );
  }
}
