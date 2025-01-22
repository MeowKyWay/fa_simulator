import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle error(BuildContext context, [bool isError = true]) {
    if (!isError) {
      return this;
    }
    return copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: Theme.of(context).colorScheme.error,
      decorationThickness: 3,
    );
  }
}
