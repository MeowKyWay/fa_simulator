import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:fa_simulator/widget/overlay/overlay_body.dart';
import 'package:flutter/material.dart';

class DiagramOverlay extends StatelessWidget {
  final Widget child;
  final Function() close;

  const DiagramOverlay({
    super.key,
    required this.child,
    required this.close,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayBackground(
      child: OverlayBody(
        showTopBar: true,
        close: close,
        child: child,
      ),
    );
  }
}
