import 'package:flutter/material.dart';

class RenameTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextStyle? textStyle;

  const RenameTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextFormField(
        maxLines: 5,
        minLines: 1,
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: textStyle ?? TextTheme.of(context).labelLarge,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
