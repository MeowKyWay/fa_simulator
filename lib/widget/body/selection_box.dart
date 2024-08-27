import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionBox extends StatelessWidget {
  const SelectionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionAreaProvider>(
        builder: (context, selectionArea, child) {
      return selectionArea.rect == null
          ? const SizedBox()
          : Positioned(
              left: selectionArea.rect!.left,
              top: selectionArea.rect!.top,
              width: selectionArea.rect!.width,
              height: selectionArea.rect!.height,
              child: DottedBorder(
                dashPattern: const [10, 5],
                child: Container(),
              ),
            );
    });
  }
}
