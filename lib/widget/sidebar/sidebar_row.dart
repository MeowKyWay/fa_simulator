import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class SidebarRow extends StatelessWidget {
  final Widget child;

  const SidebarRow({
    super.key,
    required this.child,
  });

  @override Widget build(BuildContext context) {
        return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: secondaryLineColor,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}