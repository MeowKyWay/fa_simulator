import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/resource/theme/diagram_theme.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:fa_simulator/widget/provider/start_arrow_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/app.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiagramList()),
        ChangeNotifierProvider(create: (context) => FocusProvider()),
        ChangeNotifierProvider(create: (context) => PalleteFeedbackProvider()),
        ChangeNotifierProvider(create: (context) => NewTransitionProvider()),
        ChangeNotifierProvider(
            create: (context) => TransitionDraggingProvider()),
        ChangeNotifierProvider(create: (context) => DiagramDraggingProvider()),
        ChangeNotifierProvider(
            create: (context) => StartArrowFeedbackProvider()),
        ChangeNotifierProvider(create: (context) => RenamingProvider()),
      ],
      child: MaterialApp(
        theme: diagramTheme,
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
