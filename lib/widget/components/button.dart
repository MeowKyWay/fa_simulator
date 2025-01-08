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

  const Button({
    super.key,
    this.onPressed,
    this.text = '',
    this.width,
    this.height,
    this.type = ButtonType.normal,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.labelMedium ?? TextStyle();
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
        ),
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
