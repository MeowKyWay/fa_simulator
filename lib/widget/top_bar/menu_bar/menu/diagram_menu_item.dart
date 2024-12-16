import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class DiagramMenuItem {
  final String label;
  final String shortcut;

  const DiagramMenuItem({
    required this.label,
    this.shortcut = '',
  });

  PopupMenuItem build() {
    return PopupMenuItem(
      height: 30,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textSmall,
              ),
            ),
            Text(
              shortcut,
              style: textSmall.copyWith(
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
