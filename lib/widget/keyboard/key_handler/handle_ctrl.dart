// import 'package:fa_simulator/action/app_action_dispatcher.dart';
// import 'package:fa_simulator/action/copy_paste/copy_action.dart';
// import 'package:fa_simulator/action/copy_paste/paste_action.dart';
// import 'package:fa_simulator/action/file/new_diagram_action.dart';
// import 'package:fa_simulator/action/file/open_diagram_action.dart';
// import 'package:fa_simulator/action/file/save_diagram_action.dart';
// import 'package:fa_simulator/action/file/save_diagram_as_action.dart';
// import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void handleCtrl(LogicalKeyboardKey key, BuildContext context) {
//   switch (key) {
//     case LogicalKeyboardKey.keyZ:
//       _handleUndoRedo();
//     case LogicalKeyboardKey.keyC:
//       _handleCopy();
//     case LogicalKeyboardKey.keyV:
//       _handlePaste();
//     case LogicalKeyboardKey.keyS:
//       _handleSave();
//     case LogicalKeyboardKey.keyN:
//       _handleNew(context);
//     case LogicalKeyboardKey.keyO:
//       _handleOpen(context);
//     default:
//       break;
//   }
// }

// void _handleUndoRedo() {
//   if (!KeyboardProvider().focusNode.hasPrimaryFocus) return;
//   // If shift is pressed, redo
//   if (KeyboardProvider().modifierKeys.contains(LogicalKeyboardKey.shiftLeft)) {
//     AppActionDispatcher().redo();
//     return;
//   }
//   // Else undo
//   AppActionDispatcher().undo();
// }

// void _handleCopy() {
//   AppActionDispatcher().execute(CopyAction());
// }

// void _handlePaste() {
//   AppActionDispatcher().execute(PasteAction());
// }

// void _handleSave() async {
//   await Future.delayed(Duration(milliseconds: 100));
//   if (KeyboardProvider().isShiftPressed) {
//     AppActionDispatcher().execute(SaveDiagramAsAction());
//   } else {
//     AppActionDispatcher().execute(SaveDiagramAction());
//   }
// }

// void _handleNew(BuildContext context) {
//   AppActionDispatcher().execute(
//     NewDiagramAction(context: context),
//   );
// }

// void _handleOpen(BuildContext context) {
//   AppActionDispatcher().execute(
//     OpenDiagramAction(context: context),
//   );
// }
