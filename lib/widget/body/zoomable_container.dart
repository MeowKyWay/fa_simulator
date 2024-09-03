import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZoomableContainer extends StatefulWidget {
  final Widget child;

  const ZoomableContainer({
    super.key,
    required this.child,
  });

  @override
  State<ZoomableContainer> createState() {
    return _ZoomableContainerState();
  }
}

class _ZoomableContainerState extends State<ZoomableContainer> {

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      onInteractionEnd: (details) {
        
      },
      constrained: false,
      maxScale: maxScale,
      minScale: minScale,
      scaleEnabled: true,
      child: widget.child,
    );
  }
}
