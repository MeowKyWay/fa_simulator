import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/widget/provider/selection_area_provider.dart';
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
                padding: EdgeInsets.zero,
                dashPattern: const [5, 2.5],
                color: Colors.grey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
            );
    });
  }
}
