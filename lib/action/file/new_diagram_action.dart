import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_new.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class NewDiagramAction extends AppUnrevertableAction {
  final BuildContext context;

  NewDiagramAction({
    required this.context,
  });

  @override
  Future<void> execute() async {
    if (!DiagramList().isSaved) {
      if (!await confirm(
        'All changes will be lost!',
        context,
        confirm: 'Discard changes',
        cancle: 'Cancle',
      )) {
        return;
      }
    }

    if (!context.mounted) {
      return;
    }

    DiagramNew().newDiagram(context);
  }
}
