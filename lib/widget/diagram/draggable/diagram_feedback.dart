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
        child: Container(
          color: const Color.fromARGB(100, 33, 149, 243),
        ),
      ),
    );
  }
}
