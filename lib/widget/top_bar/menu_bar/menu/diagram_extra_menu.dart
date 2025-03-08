import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:flutter/material.dart';

class DiagramExtraMenu extends DiagramMenu {
  final Function() changeTheme;

  const DiagramExtraMenu({
    super.key,
    required super.isOpen,
    required super.close,
    required this.changeTheme,
  });

  @override
  String get label => 'Extra';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramContextMenuItem(
          label: 'Change Theme',
          onTap: () {
            changeTheme();
            close();
          },
          padding: padding,
        ),
      ];
}
