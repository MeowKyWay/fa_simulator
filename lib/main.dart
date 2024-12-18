import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:fa_simulator/widget/provider/selection_area_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/app.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiagramList()),
        ChangeNotifierProvider(create: (context) => SelectionAreaProvider()),
        ChangeNotifierProvider(create: (context) => BodyProvider()),
        ChangeNotifierProvider(create: (context) => KeyboardProvider()),
        ChangeNotifierProvider(create: (context) => PalleteFeedbackProvider()),
        ChangeNotifierProvider(create: (context) => NewTransitionProvider()),
        ChangeNotifierProvider(
            create: (context) => TransitionDraggingProvider()),
        ChangeNotifierProvider(create: (context) => DiagramDraggingProvider()),
        ChangeNotifierProvider(create: (context) => FileProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryTextColor, // Custom caret (cursor) color`
            selectionColor:
                Colors.blue.withOpacity(0.5) // Custom selection color
          ),
          dividerTheme: const DividerThemeData(
            color: primaryLineColor,
          ),
          hoverColor: primaryColor,
        ),
        home: const Scaffold(
          body: DefaultTextStyle(
            style: TextStyle(
              color: primaryTextColor,
              decoration: textDecoration,
              fontSize: 20,
            ),
            child: App(),
          ),
        ),
      ),
    );
  }
}
