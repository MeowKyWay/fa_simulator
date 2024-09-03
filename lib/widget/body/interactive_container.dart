import 'dart:developer';

import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class InteractiveContainer extends StatefulWidget {
  final Widget child;

  const InteractiveContainer({
    super.key,
    required this.child,
  });

  @override
  State<InteractiveContainer> createState() {
    return _InteractiveContainerState();
  }
}

class _InteractiveContainerState extends State<InteractiveContainer> {
  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    ValueNotifier<int> notifier = ValueNotifier(0);

    return OverflowBox(
      maxWidth: bodySize.width,
      maxHeight: bodySize.height,
      child: MatrixGestureDetector(
        shouldRotate: false,
        onMatrixUpdate: (m, tm, sm, rm) {
          log("$sm");
          matrix = MatrixGestureDetector.compose(matrix, tm, sm, null);
          notifier.value++;
        },
        child: Container(
          width: bodySize.width,
          height: bodySize.height,
          alignment: Alignment.topLeft,
          child: AnimatedBuilder(
            animation: notifier,
            builder: (ctx, child) {
              return Transform(
                transform: matrix,
                child: widget.child,
              );
            },
          ),
        ),
      ),
    );
  }
}
