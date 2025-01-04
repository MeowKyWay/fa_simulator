import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/file/new_diagram_action.dart';
import 'package:fa_simulator/action/file/open_diagram_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:flutter/material.dart';

final selectDiagramOverlay = OverlayEntry(
  builder: (context) {
    return OverlayBackground(
        child: Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(
          color: primaryLineColor,
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
              _buildButton('Create new diagram', _newDiagram, context),
              _buildButton('Open existing diagram', _openDiagram, context),
            ],
          ),
        ),
      ),
    ));
  },
);

Widget _buildButton(String text, VoidCallback onPressed, BuildContext context) {
  TextStyle style = Theme.of(context).textTheme.labelMedium ?? TextStyle();
  return OutlinedButton(
    onPressed: onPressed,
    child: SizedBox(
      width: 200,
      height: 40,
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    ),
  );
}

void _newDiagram() {
  AppActionDispatcher().execute(
    NewDiagramAction(),
    postAction: _closeOverlay,
  );
}

void _openDiagram() {
  AppActionDispatcher().execute(
    OpenDiagramAction(),
    postAction: _closeOverlay,
  );
}

void _closeOverlay() {
  selectDiagramOverlay.remove();
}
