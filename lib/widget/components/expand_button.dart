import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  final bool isExpanded;
  final Function()? onPressed;
  final Color? color;

  const ExpandButton({
    super.key,
    required this.isExpanded,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(3),
      iconSize: 20,
      constraints: BoxConstraints(
        minWidth: 13,
        minHeight: 13,
      ),
      icon: Icon(
        isExpanded ? Icons.expand_less : Icons.expand_more,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: onPressed,
    );
  }
}
