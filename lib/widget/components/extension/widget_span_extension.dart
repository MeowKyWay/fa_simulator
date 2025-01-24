import 'package:flutter/material.dart';

extension WidgetSpanExtension on WidgetSpan {
  WidgetSpan baseAlign() {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: child,
      style: style,
    );
  }
}
