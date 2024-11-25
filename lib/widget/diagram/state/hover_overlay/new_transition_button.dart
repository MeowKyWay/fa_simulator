import 'package:flutter/material.dart';

class NewTransitionButton extends StatefulWidget {
  final Offset position;

  const NewTransitionButton({
    super.key,
    required this.position,
  });

  @override
  State<NewTransitionButton> createState() => _NewTransitionButtonState();
}

class _NewTransitionButtonState extends State<NewTransitionButton> {
  final double _ringWidth = 7.5;

  late Offset position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - _ringWidth,
      top: widget.position.dy - _ringWidth,
      child: IgnorePointer(
        child: Container(
          width: _ringWidth * 2,
          height: _ringWidth * 2,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.75),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
