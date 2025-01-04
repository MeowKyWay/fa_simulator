import 'package:flutter/material.dart';

class OverlayBackground extends StatelessWidget {

  final Widget? child;

  const OverlayBackground({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(
          alpha: 128,
        ), // Semi-transparent background
        child: Center(child: child),
      ),
    );
  }
}