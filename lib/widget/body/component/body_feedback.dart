import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_feedback.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyFeedback extends StatelessWidget {
  const BodyFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramDraggingProvider>(
        builder: (context, provider, child) {
      try {
        Offset position = BodyProvider().getSnappedPosition(provider.position);
        Size size = provider.size;
        return DiagramFeedback(
          position: position,
          size: size,
        );
      } catch (e) {
        return Container();
      }
    });
  }
}
