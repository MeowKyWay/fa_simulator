import 'package:fa_simulator/widget/components/extension/color_extension.dart';
import 'package:flutter/material.dart';

ThemeData diagramTheme = ThemeData(
    primarySwatch: Colors.blue,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withAlpha((255 * 0.5).toInt()),
      cursorColor: Colors.blue,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.black,
    ),
    textTheme: textTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    hoverColor: Colors.green.withOpa(0.5),
    focusColor: _focusColor,
    colorScheme: darkTheme,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white.withOpa(0.5),
      ),
    ));

ColorScheme darkTheme = ColorScheme(
  brightness: Brightness.dark,
  primary: _primaryColor,
  onPrimary: Colors.white,
  secondary: _secondaryColor,
  onSecondary: Colors.white,
  tertiary: _tertiaryColor,
  onTertiary: Colors.white,
  outline: Colors.white,
  outlineVariant: _outlineColor,
  error: Color.fromRGBO(162, 1, 37, 1),
  onError: Colors.white,
  errorContainer: Color.fromRGBO(189, 0, 43, 1),
  surface: _surfaceColor,
  onSurface: _gridPrimalyColor,
  onSurfaceVariant: _gridSecondaryColor,
);

final textTheme = TextTheme(
  titleLarge: TextStyle(
    color: Colors.white,
    fontSize: 24,
  ),
  titleMedium: TextStyle(
    color: Colors.white,
    fontSize: 18,
  ),
  titleSmall: TextStyle(
    color: Colors.white,
    fontSize: 16,
  ),

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

  // Table data
  bodyLarge: TextStyle(
    fontFamily: 'Roboto Mono',
    color: Colors.white,
    fontSize: 18,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Roboto Mono',
    color: Colors.white,
    fontSize: 14,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Roboto Mono',
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
        color: _outlineColor,
      ),
    ),
  ),
);
const Color _surfaceColor = Color.fromARGB(255, 24, 20, 29);
const Color _primaryColor = Color.fromARGB(255, 27, 29, 30);
const Color _secondaryColor = Color.fromARGB(255, 20, 24, 29);
const Color _tertiaryColor = Color.fromARGB(255, 79, 84, 86);

const Color _gridPrimalyColor = Color.fromARGB(255, 66, 66, 66);
const Color _gridSecondaryColor = Color.fromARGB(255, 31, 29, 35);

const Color _focusColor = Colors.blue;

const Color _outlineColor = Color.fromARGB(255, 80, 87, 89);
