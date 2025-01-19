import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:flutter/material.dart';

class TransitionsOverlay extends StatelessWidget {
  const TransitionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayBackground(
      child: const Text('Transitions'),
    );
  }
}