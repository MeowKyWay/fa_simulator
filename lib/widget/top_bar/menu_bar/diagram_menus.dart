import 'dart:developer';

import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_file_menu.dart';
import 'package:flutter/material.dart';

class DiagramMenus extends StatelessWidget {
  const DiagramMenus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: [
          DiagramFileMenu(),
          Button(
            onPressed: () async {
              confirm("dsafxwgcdhvjbaklwd,awmdbjvgawtgy", context)
                  .then((value) {
                log(value.toString());
              });
            },
            text: "test",
          )
        ],
      ),
    );
  }
}
