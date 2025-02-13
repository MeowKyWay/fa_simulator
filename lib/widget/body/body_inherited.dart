import 'package:fa_simulator/widget/body/inherited_widget/keyboard/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/body/inherited_widget/selection_data.dart';
import 'package:flutter/material.dart';

class BodyInherited extends StatelessWidget {
  final FocusNode keyboardFocusNode;
  final DiagramSelectionDetails selectionDetails;

  final Widget child;

  const BodyInherited({
    super.key,
    required this.keyboardFocusNode,
    required this.selectionDetails,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BodyKeyboardListener(
      focusNode: keyboardFocusNode,
      child: SelectionData(
        details: selectionDetails,
        child: child,
      ),
    );
  }
}
