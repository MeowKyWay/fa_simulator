import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/diagram/draggable/feedback_position_provider.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
import 'package:fa_simulator/widget/app.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/sidebar/pallete/pallete_feedback_provider.dart';
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
        ChangeNotifierProvider(create: (context) => StateList()),
        ChangeNotifierProvider(create: (context) => SelectionAreaProvider()),
        ChangeNotifierProvider(create: (context) => BodySingleton()),
        ChangeNotifierProvider(create: (context) => KeyboardSingleton()),
        ChangeNotifierProvider(create: (context) => FeedbackPositionProvider()),
        ChangeNotifierProvider(create: (context) => PalleteFeedbackProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: textColor, // Custom caret (cursor) color
            selectionColor:
                Colors.blue.withOpacity(0.5), // Custom selection color
          ),
        ),
        home: const Scaffold(
          body: DefaultTextStyle(
            style: TextStyle(
              color: textColor,
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
