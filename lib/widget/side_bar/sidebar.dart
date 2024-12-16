import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/side_bar/pallete/pallete.dart';
import 'package:fa_simulator/widget/side_bar/pallete/state/state_wrap.dart';
import 'package:fa_simulator/widget/side_bar/side_bar_row.dart';
import 'package:fa_simulator/widget/side_bar/sidebar_textfield.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: secondaryColor,
        border: Border(
          right: BorderSide(
            color: primaryLineColor,
            width: 1,
          ),
        ),
      ),
      height: double.infinity,
      width: 200,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SideBarRow(
              child: SideBarTextfield(),
            ),
            Pallete(
              label: "State",
              child: StateWrap(),
            ),
            Pallete(
              label: "Transition",
              child: StateWrap(),
            ),
          ],
        ),
      ),
    );
  }
}
