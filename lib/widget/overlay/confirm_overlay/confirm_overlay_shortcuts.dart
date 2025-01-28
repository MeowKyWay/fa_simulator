import 'package:fa_simulator/action/intent/response_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmOverlayShortcuts extends StatelessWidget {
  final Widget child;

  const ConfirmOverlayShortcuts({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        _esc: CancelIntent(),
        _enter: ConfirmIntent(),
      },
      child: child,
    );
  }
}

final _esc = SingleActivator(
  LogicalKeyboardKey.escape,
);

final _enter = SingleActivator(
  LogicalKeyboardKey.enter,
);
