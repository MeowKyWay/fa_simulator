import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/interactive_container/matrix_gesture_detecture2.dart';
import 'package:flutter/material.dart';

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
  final _padding = 5;
  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    ValueNotifier<int> notifier = ValueNotifier(0);

    return OverflowBox(
      maxWidth: bodySize.width * _padding,
      maxHeight: bodySize.height * _padding,
      child: MatrixGestureDetector2(
        shouldRotate: false,
        onMatrixUpdate: (m, tm, sm, rm) {
          Matrix4 newMatrix =
              MatrixGestureDetector2.compose(matrix, tm, sm, null);
          if (!scaleLimiter(newMatrix)) {
            return;
          }
          matrix = newMatrix;
          notifier.value++;
        },
        child: Container(
          width: bodySize.width * _padding,
          height: bodySize.height * _padding,
          alignment: Alignment.topLeft,
          child: AnimatedBuilder(
            animation: notifier,
            builder: (ctx, child) {
              return Transform(
                transform: matrix,
                child: Container(
                  width: bodySize.width * _padding,
                  height: bodySize.height * _padding,
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: widget.child,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool scaleLimiter(Matrix4 m) {
    if (m[0] < minScale || m[0] > maxScale) {
      return false;
    }
    return true;
  }
}
