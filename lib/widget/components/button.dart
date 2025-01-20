import 'package:flutter/material.dart';

enum ButtonType {
  normal,
  warning,
}

enum ButtonVariant {
  outlined,
  contained,
}

class Button extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  final double? width;
  final double? height;

  final ButtonType type;
  final ButtonVariant style;

  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const Button({
    super.key,
    this.onPressed,
    this.text = '',
    this.width,
    this.height,
    this.type = ButtonType.normal,
    this.style = ButtonVariant.outlined,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ButtonVariant.contained:
        return IntrinsicHeight(
          child: ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                padding ?? const EdgeInsets.symmetric(horizontal: 10),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                type == ButtonType.warning
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.tertiary,
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
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
                  style: textStyle ?? Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ),
        );
      case ButtonVariant.outlined:
        return IntrinsicHeight(
          child: OutlinedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                padding ?? const EdgeInsets.symmetric(horizontal: 10),
              ),
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
                  style: textStyle ?? Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ),
        );
    }
  }
}
