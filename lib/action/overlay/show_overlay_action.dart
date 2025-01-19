import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:flutter/material.dart';

class ShowOverlayAction extends AppUnrevertableAction {
  final Type overlay;
  final BuildContext context;

  ShowOverlayAction({
    required this.overlay,
    required this.context,
  });

  @override
  Future<void> execute() async {
    Overlay.of(context).insert(
      OverlayEntry(
        builder: (context) => overlay as StatelessWidget,
      ),
    );
  }
}
