
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class RenameTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextStyle textStyle;

  const RenameTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    this.textStyle = textXL,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      style: textStyle,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
    );
  }
}
