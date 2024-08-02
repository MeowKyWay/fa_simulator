import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FocusOverlay extends StatelessWidget {
  final Widget child;
  final bool hasFocus;

  const FocusOverlay({super.key, required this.child, required this.hasFocus});

  @override
  Widget build(BuildContext context) {
    if (hasFocus) {
      return DottedBorder(
        padding:  const EdgeInsets.all(0),
        child: child,
      );
    }
    return child;
  }
}
