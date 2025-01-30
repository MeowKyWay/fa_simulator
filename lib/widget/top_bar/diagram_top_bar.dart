import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/diagram_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagramTopBar extends StatelessWidget {
  const DiagramTopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, provider, child) {
      return SizedBox(
        height: 105,
        width: double.infinity,
        child: Column(
          children: [
            DiagramMenuBar(),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
