import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_feedback.dart';
import 'package:fa_simulator/widget/provider/feedback_position_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyFeedback extends StatelessWidget {
  const BodyFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedbackPositionProvider>(
        builder: (context, feedbackPositionProvider, child) {
      if (feedbackPositionProvider.size == null ||
          feedbackPositionProvider.position == null) {
        return Container();
      }
      return DiagramFeedback(
        size: feedbackPositionProvider.size!,
        position: feedbackPositionProvider.position!,
      );
    });
  }
}
