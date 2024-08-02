import 'package:flutter/material.dart';

class Dragable extends StatefulWidget {
  final double left;
  final double top;
  final Widget child;
  final Function? focus;

  const Dragable({
    super.key,
    required this.left,
    required this.top,
    required this.child,
    this.focus,
  });

  @override
  State<Dragable> createState() {
    return _DragableState();
  }
}

class _DragableState extends State<Dragable> {

  late double _top;
  late double _left;

  @override
  void initState() {
    _top = widget.top;
    _left = widget.left;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _left += details.delta.dx;
            _top += details.delta.dy;
            widget.focus!();
          });
        },
        child: widget.child,
      ),
    );
  }
}