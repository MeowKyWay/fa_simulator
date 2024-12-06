import 'package:flutter/material.dart';

class TransitionPivotButton extends StatefulWidget {
  final Offset position;
  final Offset offset;
  final bool hasFocus;

  const TransitionPivotButton({
    super.key,
    required this.position,
    this.offset = Offset.zero,
    this.hasFocus = false,
  });

  @override
  State<TransitionPivotButton> createState() => _TransitionPivotButtonState();
}

class _TransitionPivotButtonState extends State<TransitionPivotButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    double buttonSize = 15;

    return Positioned(
      left: widget.position.dx - buttonSize / 2,
      top: widget.position.dy - buttonSize / 2,
      child: ClipOval(
        child: MouseRegion(
            onEnter: (event) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (event) {
              setState(() {
                _isHovered = false;
              });
            },
            cursor: SystemMouseCursors.grab,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: _isHovered || widget.hasFocus
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    )
                  : const BoxDecoration(),
            )),
      ),
    );
  }
}
