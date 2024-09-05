import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/sidebar/sidebar_row.dart';
import 'package:flutter/material.dart';

class Pallete extends StatefulWidget {
  final String label;
  final Widget child;

  const Pallete({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  State<Pallete> createState() => _PalleteState();
}

class _PalleteState extends State<Pallete> {
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
                  color: textColor,
                  size: textMediumSize,
                ),
                Text(
                  widget.label,
                  style: textMedium,
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
