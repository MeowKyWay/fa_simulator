import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class DiagramMenuItem extends StatelessWidget {
  final String label;
  final String shortcut;
  final bool enabled;
  final Function()? action;

  const DiagramMenuItem({
    super.key,
    required this.label,
    this.shortcut = '',
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
              style: textS.copyWith(
                color: enabled ? primaryTextColor : primaryDisabledTextColor,
              ),
            ),
          ),
          Text(
            shortcut,
            style: textS.copyWith(
              color: enabled ? secondaryTextColor : secondaryDisabledTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
