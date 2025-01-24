import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:flutter/material.dart';

class DraggableOverlay extends StatelessWidget {

  const DraggableOverlay({
    super.key,
  });

  Rect? overlayRect() {
    double left = double.infinity;
    double top = double.infinity;
    double right = 0;
    double bottom = 0;

    List<StateType> focusedStates = DiagramList().focusedStates;
    if (focusedStates.isEmpty) {
      return null;
    }

    for (int i = 0; i < focusedStates.length; i++) {
      double padding = stateSize / 2;
      Offset position = Offset(
        focusedStates[i].position.dx,
        focusedStates[i].position.dy,
      );
      left = left < position.dx - padding ? left : position.dx - padding;
      top = top < position.dy - padding ? top : position.dy - padding;
      right = right > position.dx + padding ? right : position.dx + padding;
      bottom = bottom > position.dy + padding ? bottom : position.dy + padding;
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  @override
  Widget build(BuildContext context) {
    Rect? rect = overlayRect();
    if (rect == null) {
      return Container();
    }
    return Positioned(
      left: rect.left,
      top: rect.top,
      child: SizedBox(
        key: BodyProvider().getDraggableOverlayKey,
        width: rect.right - rect.left,
        height: rect.bottom - rect.top,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
