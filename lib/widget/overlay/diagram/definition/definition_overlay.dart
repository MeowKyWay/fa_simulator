import 'package:fa_simulator/widget/overlay/diagram/definition/states_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/diagram_overlay.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/alphabet_row.dart';
import 'package:flutter/material.dart';

OverlayEntry definitionOverlay() {
  OverlayEntry? overlay;
  overlay = OverlayEntry(
    builder: (context) => DiagramOverlay(
      close: () {
        overlay!.remove();
      },
      child: SizedBox(
        height: 700,
        width: 1000,
        child: ListView(
          children: [
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
            Text(
              'Definition',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
            StatesRow(),
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
            AlphabetRow(),
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
          ],
        ),
      ),
    ),
  );
  return overlay;
}
