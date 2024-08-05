import 'package:flutter/material.dart';

class ZoomableContainer extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onScaleChange;

  const ZoomableContainer({
    super.key,
    required this.child,
    required this.onScaleChange,
  });

  @override
  State<ZoomableContainer> createState() {
    return _ZoomableContainerState();
  }
}

class _ZoomableContainerState extends State<ZoomableContainer> {
  final TransformationController _transformationController =
      TransformationController();

  double getScale() {
    final Matrix4 matrix = _transformationController.value;
    double scale = matrix.getMaxScaleOnAxis();

    return scale;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      constrained: false,
      maxScale: 5,
      minScale: 0.1,
      onInteractionUpdate: (details) {
        widget.onScaleChange(getScale());
      },
      child: widget.child,
    );
  }
}
