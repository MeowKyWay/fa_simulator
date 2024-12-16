import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_file_menu.dart';
import 'package:flutter/material.dart';

class DiagramMenus extends StatelessWidget {
  const DiagramMenus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: [
          DiagramFileMenu(),
        ],
      ),
    );
  }
}
