import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagramContextMenu {
  static OverlayEntry? _overlayEntry;

  static void hide() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Show the context menu at the given global position.
  static void show({
    required BuildContext context,
    required Offset position,
    required List<Widget> menu,
    double? width,
    Function()? onClose,
  }) {
    hide();

    _overlayEntry = OverlayEntry(
      builder: (context) =>
          Consumer<DiagramList>(builder: (context, provider, child) {
        return Stack(
          children: [
            // Transparent background to detect outside clicks
            Positioned.fill(
              child: Listener(
                onPointerUp: (_) {
                  hide();
                  onClose?.call();
                }, // Close on tap outside
                behavior: HitTestBehavior.translucent,
              ),
            ),
            // Context menu positioned at the cursor
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                textStyle: Theme.of(context).textTheme.labelSmall,
                color: Theme.of(context).colorScheme.primary,
                child: IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...menu,
                        ]),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
}
