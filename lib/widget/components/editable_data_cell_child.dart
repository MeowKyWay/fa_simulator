import 'package:flutter/material.dart';

enum EditableDataCellType {
  text,
  dropdown,
  boolean,
}

class EditableDataCellChild extends StatelessWidget {
  // Text
  final TextEditingController? textController;
  final String? hintText;

  final FocusNode? focusNode;
  final EditableDataCellType type;
  final bool isUnsaved;

  final TextStyle? textStyle;

  const EditableDataCellChild({
    super.key,
    this.textController,
    this.hintText,
    this.focusNode,
    required this.type,
    required this.isUnsaved,
    this.textStyle,
  }) : assert((type == EditableDataCellType.text) == (textController != null));

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Expanded(child: Builder(builder: (context) {
          switch (type) {
            case EditableDataCellType.text:
              return TextField(
                style: textStyle,
                controller: textController,
                focusNode: focusNode,
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: textStyle?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            case EditableDataCellType.dropdown:
              return Text('dropdown');
            case EditableDataCellType.boolean:
              return Text('boolean');
          }
        })),
        Icon(
          isUnsaved ? Icons.circle : Icons.edit,
          size: 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
  }
}
