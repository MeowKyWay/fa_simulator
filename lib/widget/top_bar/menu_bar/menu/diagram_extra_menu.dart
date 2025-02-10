import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramExtraMenu extends DiagramMenu {
  const DiagramExtraMenu({
    super.key,
    required super.isOpen,
    required super.close,
  });

  @override
  String get label => 'Extra';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramMenuItem(
          label: 'Change Theme',
          shortcut: DiagramShortcut().undo,
          action: () {
            throw UnimplementedError();
          },
        ),
      ];
}
