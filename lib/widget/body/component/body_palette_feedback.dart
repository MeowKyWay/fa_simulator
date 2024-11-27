import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyPaletteFeedback extends StatelessWidget {
  const BodyPaletteFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PalleteFeedbackProvider>(
        builder: (context, palleteFeedbackProvider, child) {
      if (palleteFeedbackProvider.feedback == null ||
          palleteFeedbackProvider.position == null) {
        return Container();
      }
      return palleteFeedbackProvider.feedback!;
    });
  }
}
