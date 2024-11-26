import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class DiagramFeedback extends StatelessWidget {
  final Size size;
  final Offset position;

  const DiagramFeedback({
    super.key,
    required this.size,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: DottedBorder(
          color: feedbackBorderColor,
          dashPattern: const [5, 2.5],
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
