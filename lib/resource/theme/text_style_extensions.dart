import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle error(BuildContext context, [Object? isError]) {
    if ((isError is bool && !isError) || isError == null) {
      return this;
    }
    return copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: Theme.of(context).colorScheme.error,
      decorationThickness: 3,
    );
  }

  TextStyle red(BuildContext context, [Object? isError]) {
    if ((isError is bool && !isError) || isError == null) {
      return this;
    }
    return copyWith(
      color: Theme.of(context).colorScheme.error,
    );
  }
}
