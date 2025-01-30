import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/diagram_icon.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/diagram_menus.dart';
import 'package:flutter/material.dart';

class DiagramMenuBar extends StatelessWidget {
  const DiagramMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            const DiagramIcon(),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    // File name
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(9.5, 5, 0, 0),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        '${DiagramList().file.name}.${DiagramList().type.toString()}',
                        style: textL.copyWith(
                          color: secondaryTextColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    // Menu
                    width: double.infinity,
                    height: 30,
                    child: DiagramMenus(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
