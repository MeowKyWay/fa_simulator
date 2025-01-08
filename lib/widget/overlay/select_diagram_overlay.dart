import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/file/new_diagram_action.dart';
import 'package:fa_simulator/action/file/open_diagram_action.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:flutter/material.dart';

final selectDiagramOverlay = OverlayEntry(
  builder: (context) {
    return OverlayBackground(
        child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
        child: IntrinsicHeight(
          child: Column(
            spacing: 10,
            children: [
              Button(
                text: 'New diagram',
                onPressed: () {
                  AppActionDispatcher().execute(
                    NewDiagramAction(
                      context: context,
                    ),
                    postAction: _closeOverlay,
                  );
                },
                width: 200,
                height: 40,
              ),
              Button(
                text: 'Open diagram',
                onPressed: () {
                  AppActionDispatcher().execute(
                    OpenDiagramAction(
                      context: context,
                    ),
                    postAction: _closeOverlay,
                  );
                },
                width: 200,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    ));
  },
);

void _closeOverlay() {
  selectDiagramOverlay.remove();
}
