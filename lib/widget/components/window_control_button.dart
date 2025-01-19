import 'package:flutter/material.dart';

class WindowControlButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final Color color;

  const WindowControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.close),
        padding: const EdgeInsets.all(3),
        iconSize: 10,
        constraints: BoxConstraints(
          minWidth: 13,
          minHeight: 13,
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
