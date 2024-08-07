import 'package:fa_simulator/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoveButton extends StatelessWidget {
  final Function(Offset) onDragEnd;
  final Widget feedback;
  final double scale;

  const MoveButton({
    super.key,
    required this.onDragEnd,
    required this.feedback,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: stateFocusOverlayButtonSize,
      width: stateFocusOverlayButtonSize,
      child: Draggable(
        feedback: Transform.scale(
          scale: scale,
          alignment: Alignment.bottomRight,
          child: feedback,
        ),
        onDragEnd: (details) {
          onDragEnd(details.offset + Offset(stateSize/2, stateSize/2) * (2-scale));
        },
        dragAnchorStrategy: (draggable, context, position) {
          return Offset.zero + Offset(stateSize, stateSize);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.arrowsUpDownLeftRight,
              size: stateFocusOverlayButtonSize / 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
