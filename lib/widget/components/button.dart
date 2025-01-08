import 'package:flutter/material.dart';

enum ButtonType {
  normal,
  warning,
}

class Button extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  final double? width;
  final double? height;

  final ButtonType type;

  final TextStyle? style;

  const Button({
    super.key,
    this.onPressed,
    this.text = '',
    this.width,
    this.height,
    this.type = ButtonType.normal,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            type == ButtonType.warning
                ? Theme.of(context).colorScheme.error
                : Colors.transparent,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            type == ButtonType.warning
                ? Theme.of(context).colorScheme.error
                : Colors.transparent,
          ),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(
              color: type == ButtonType.warning
                  ? Theme.of(context).colorScheme.errorContainer
                  : Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: style ?? Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ),
    );
  }
}
