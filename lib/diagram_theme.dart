import 'package:flutter/material.dart';

ThemeData diagramTheme = ThemeData(
  primarySwatch: Colors.blue,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.blue.withOpacity(0.5), // Custom selection color
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black,
  ),
  hoverColor: Colors.blue,
  textTheme: textTheme,
  outlinedButtonTheme: outlinedButtonTheme,
);

final textTheme = TextTheme(
  labelLarge: TextStyle(
    color: Colors.white,
    fontSize: 20,
  ),
  labelMedium: TextStyle(
    color: Colors.white,
    fontSize: 14,
  ),
  labelSmall: TextStyle(
    color: Colors.white,
    fontSize: 12,
  ),
);

final outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    side: WidgetStateProperty.all(
      BorderSide(
        color: _primaryLineColor,
      ),
    ),
  ),
);
const Color _primaryColor = Color.fromARGB(255, 24, 20, 29);
const Color _secondaryColor = Color.fromARGB(255, 27, 29, 30);

const Color _gridPrimalyColor = Color.fromARGB(255, 66, 66, 66);
const Color _gridSecondaryColor = Color.fromARGB(255, 31, 29, 35);

const Color _stateBorderColor = Colors.white;
const Color _stateBackgroundColor = Color.fromARGB(255, 20, 24, 29);

const Color _focusColor = Colors.blue;
const Color _feedbackBorderColor = Colors.white;

const Color _primaryLineColor = Color.fromARGB(255, 80, 87, 89);
const Color _secondaryLineColor = Color.fromARGB(255, 64, 70, 71);
