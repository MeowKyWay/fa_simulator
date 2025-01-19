import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:flutter/material.dart';

class AlphabetOverlay extends StatelessWidget {
  const AlphabetOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayBackground(
      child: const Text('Alphabet'),
    );
  }
}