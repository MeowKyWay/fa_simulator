import 'package:fa_simulator/widget/overlay/diagram/diagram_overlay.dart';
import 'package:flutter/material.dart';

class StatesOverlay {
  OverlayEntry build(BuildContext context) {

    OverlayEntry? overlay;

    overlay = OverlayEntry(
      builder: (context) => DiagramOverlay(
        close: () {
          overlay!.remove();
        },
        child: Column(
          children: [
            Text('States'),
          ],
        ),
      ),
    );

    return overlay;
  }
}
