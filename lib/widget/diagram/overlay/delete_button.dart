import 'package:fa_simulator/config.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: stateFocusOverlayButtonSize,
      width: stateFocusOverlayButtonSize,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.close, // X icon
                color: Colors.white,
                size: stateFocusOverlayButtonSize / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
