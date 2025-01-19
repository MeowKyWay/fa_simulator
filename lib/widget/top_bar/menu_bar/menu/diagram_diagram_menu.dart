import 'dart:developer';

import 'package:fa_simulator/widget/overlay/diagram/states_overlay.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramDiagramMenu extends DiagramMenu {
  const DiagramDiagramMenu({
    super.key,
  });

  @override
  String get label => 'Diagram';

  @override
  List<PopupMenuEntry<Object?>> items(BuildContext context) => [
        DiagramMenuItem(
            label: 'states',
            action: () {
              showOverlay(StatesOverlay().build(context), context);
            }).build(),
      ];

  void showOverlay(OverlayEntry overlay, BuildContext context) {
    log('DiagramDiagramMenu.showOverlay');
    Overlay.of(context).insert(
      overlay,
    );
  }
}
