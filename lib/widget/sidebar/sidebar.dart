import 'package:fa_simulator/widget/sidebar/palette/palette.dart';
import 'package:fa_simulator/widget/sidebar/palette/state/state_wrap.dart';
import 'package:fa_simulator/widget/sidebar/sidebar_row.dart';
import 'package:fa_simulator/widget/sidebar/sidebar_textfield.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      height: double.infinity,
      width: 200,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SidebarRow(
              child: SideBarTextfield(),
            ),
            Palette(
              label: "State",
              child: StateWrap(),
            ),
            Palette(
              label: "Transition",
              child: StateWrap(),
            ),
          ],
        ),
      ),
    );
  }
}
