import 'package:flutter/material.dart';

class DiagramMenuItem extends StatelessWidget {
  final String label;
  final String shortcut;
  final bool enabled;
  final Function()? action;

  const DiagramMenuItem({
    super.key,
    required this.label,
    this.shortcut = ' ',
    this.enabled = true,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextTheme.of(context).labelSmall?.copyWith(
                    color: enabled
                        ? ColorScheme.of(context).onPrimary
                        : ColorScheme.of(context).onPrimary.withAlpha(127),
                  ),
            ),
          ),
          Text(
            shortcut,
            style: TextTheme.of(context).labelSmall?.copyWith(
                  color: enabled
                      ? ColorScheme.of(context).onPrimary
                      : ColorScheme.of(context).onPrimary.withAlpha(127),
                ),
          ),
        ],
      ),
    );
  }
}
