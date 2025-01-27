import 'package:flutter/material.dart';

extension TextFieldExtension on TextField {
  TextField plain() {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration?.copyWith(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ) ??
          const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
      style: style,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
