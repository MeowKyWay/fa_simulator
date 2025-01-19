import 'package:fa_simulator/widget/components/window_control_button.dart';
import 'package:flutter/material.dart';

class OverlayBody extends StatelessWidget {
  final Widget child;
  final String? name;
  final bool showTopBar;
  final Function()? close;

  const OverlayBody({
    super.key,
    required this.child,
    this.name,
    this.showTopBar = false,
    this.close,
  }) : assert(!showTopBar || (close != null));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showTopBar)
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    WindowControlButton(
                      icon: Icons.close,
                      onPressed: close!,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
