import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class DiagramMenuItem {
  final String label;
  final String shortcut;
  final bool enabled;
  final AppAction? action;

  const DiagramMenuItem({
    required this.label,
    this.shortcut = '',
    this.enabled = true,
    this.action,
  });

  PopupMenuItem<AppAction?> build() {
    return PopupMenuItem<AppAction>(
      value: action,
      height: 30,
      enabled: enabled,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textSmall.copyWith(
                  color: enabled? primaryTextColor : primaryDisabledTextColor,
                ),
              ),
            ),
            Text(
              shortcut,
              style: textSmall.copyWith(
                color: enabled? secondaryTextColor : secondaryDisabledTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
