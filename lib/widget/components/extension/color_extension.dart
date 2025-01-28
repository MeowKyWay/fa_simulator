import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color withOpa(double percent) {
    return withAlpha((255 * percent).toInt());
  }
}
