import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<DiagramList>(builder: (context, provider, child) {
      int errorCount = 0;
      try {
        errorCount = provider.validator.errors.errorCount;
      } catch (_) {}

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
              number: errorCount,
            ),
            DiagramPanelMenuItem(
              label: 'DEFINITION',
              onTap: () {
                onSelect(1);
              },
              isActive: selectedIndex == 1,
            ),
            DiagramPanelMenuItem(
              label: 'ALPHABET',
              onTap: () {
                onSelect(2);
              },
              isActive: selectedIndex == 2,
            ),
            DiagramPanelMenuItem(
              label: 'SIMULATION',
              onTap: () {
                onSelect(3);
              },
              isActive: selectedIndex == 3,
            ),
          ],
        ),
      );
    });
  }
}
