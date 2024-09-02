import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
import 'package:flutter/material.dart';

class DraggableOverlay extends StatelessWidget {
  final List<DiagramState> states;

  const DraggableOverlay({
    super.key,
    required this.states,
  });

  Rect? overlayRect() {
    double left = double.infinity;
    double top = double.infinity;
    double right = 0;
    double bottom = 0;

    List<DiagramState> focusedState =
        states.where((element) => element.hasFocus).toList();
    if (focusedState.isEmpty) {
      return null;
    }

    for (int i = 0; i < focusedState.length; i++) {
      double padding = stateSize / 2;
      Offset position = Offset(
        focusedState[i].position.dx,
        focusedState[i].position.dy,
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
        key: BodySingleton().getDraggableOverlayKey,
        width: rect.right - rect.left,
        height: rect.bottom - rect.top,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
