import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/state/hover_overlay/state_hover_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyStateHoverOverlay extends StatelessWidget {
  const BodyStateHoverOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, diagramList, child) {
      if (DiagramList().hoveringStateId == "") {
        return Container();
      }
      return Stack(
        children: [
          // StateHoverOverlay(
          //   state: diagramList.state(DiagramList().hoveringStateId),
          // ),
        ],
      );
    });
  }
}
