import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/file/save_diagram_action.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnsaveProgressButton extends StatelessWidget {
  const UnsaveProgressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, provider, child) {
      if (FileProvider().isSaved) {
        return Container();
      }
      return Button(
        type: ButtonType.warning,
        onPressed: () async {
          AppActionDispatcher().execute(SaveDiagramAction());
        },
        textStyle: Theme.of(context).textTheme.labelSmall,
        text: 'Unsaved changes. Click here to save.',
      );
    });
  }

  bool listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
