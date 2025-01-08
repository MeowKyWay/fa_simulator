import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_load.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:flutter/material.dart';

class OpenDiagramAction extends AppUnrevertableAction {
  final BuildContext context;

  OpenDiagramAction({
    required this.context,
  });

  @override
  Future<void> execute() async {
    if (!FileProvider().isSaved) {
      if (!await confirm(
        "All changes will be lost!",
        context,
        confirm: "Discard changes",
        cancle: "Cancle",
      )) {
        return;
      }
    }
    try {
      await DiagramLoad().load();
    } on Exception catch (e) {
      throw Exception('Failed to open diagram: $e');
    }
  }
}
