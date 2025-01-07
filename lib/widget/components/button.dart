import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  final double? width;
  final double? height;

  const Button({
    super.key,
    this.onPressed,
    this.text = '',
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.labelMedium ?? TextStyle();
    return IntrinsicHeight(
      child: OutlinedButton(
        onPressed: onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
