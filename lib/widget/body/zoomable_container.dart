import 'package:fa_simulator/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZoomableContainer extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onScaleChange;
  final TransformationController transformationController;

  const ZoomableContainer({
    super.key,
    required this.child,
    required this.onScaleChange,
    required this.transformationController,
  });

  @override
  State<ZoomableContainer> createState() {
    return _ZoomableContainerState();
  }
}

class _ZoomableContainerState extends State<ZoomableContainer> {

  double getScale() {
    final Matrix4 matrix = widget.transformationController.value;
    double scale = matrix.getMaxScaleOnAxis();

    return scale;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: widget.transformationController,
      constrained: false,
      maxScale: maxScale,
      minScale: minScale,
      scaleEnabled: true,
      onInteractionUpdate: (details) {
        widget.onScaleChange(getScale());
      },
      child: widget.child,
    );
  }
}
