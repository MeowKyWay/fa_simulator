import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/diagram_menu_bar.dart';
import 'package:flutter/material.dart';

class DiagramTopBar extends StatelessWidget {
  const DiagramTopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      width: double.infinity,
      child: Column(
        children: [
          const DiagramMenuBar(),
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: secondaryColor,
              border: Border(
                top: BorderSide(
                  color: primaryLineColor,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: primaryLineColor,
                  width: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
