import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;

  const NormalText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: normalTextStyle,
    );
  }
}

TextStyle normalTextStyle = const TextStyle(
  color: textColor,
  fontSize: textSize,
  decoration: textDecoration,
  fontWeight: FontWeight.normal,
);

class BoldText extends StatelessWidget {
  final String text;

  const BoldText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: textColor,
        fontSize: textSize,
        decoration: textDecoration,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
