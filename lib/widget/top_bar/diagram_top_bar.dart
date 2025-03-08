import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/diagram_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagramTopBar extends StatelessWidget {
  final Function() changeTheme;

  const DiagramTopBar({super.key, required this.changeTheme});
  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, provider, child) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
        ),
        height: 65,
        width: double.infinity,
        child: Column(
          children: [
            DiagramMenuBar(
              changeTheme: changeTheme,
            ),
            // Container(
            //   height: 40,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primary,
            //     border: Border(
            //       top: BorderSide(
            //         color: Theme.of(context).colorScheme.outlineVariant,
            //         width: 1,
            //       ),
            //       bottom: BorderSide(
            //         color: Theme.of(context).colorScheme.outlineVariant,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
