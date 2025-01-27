import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/widget/body/inherited_widget/selection_data.dart';
import 'package:flutter/material.dart';

class SelectionBox extends StatelessWidget {
  const SelectionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Rect? selectionArea = SelectionData.of(context)!.rect;

    return selectionArea == null
        ? const SizedBox()
        : Positioned(
            left: selectionArea.left,
            top: selectionArea.top,
            width: selectionArea.width,
            height: selectionArea.height,
            child: DottedBorder(
              padding: EdgeInsets.zero,
              dashPattern: const [5, 2.5],
              color: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha((255 * 0.3).toInt()),
                ),
              ),
            ),
          );
  }
}
