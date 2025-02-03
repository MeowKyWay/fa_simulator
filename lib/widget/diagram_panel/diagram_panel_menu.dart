import 'package:fa_simulator/widget/diagram_panel/diagram_panel_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramPanelMenu extends StatelessWidget {
  final Function(int) onSelect;
  final int selectedIndex;

  const DiagramPanelMenu({
    super.key,
    required this.onSelect,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).colorScheme.primary,
      height: 35,
      child: Row(
        spacing: 20,
        children: [
          DiagramPanelMenuItem(
            label: 'PROBLEMS',
            onTap: () {
              onSelect(0);
            },
            isActive: selectedIndex == 0,
          ),
          DiagramPanelMenuItem(
            label: 'SIMULATION',
            onTap: () {
              onSelect(1);
            },
            isActive: selectedIndex == 1,
          ),
        ],
      ),
    );
  }
}
