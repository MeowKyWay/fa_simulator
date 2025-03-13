import 'package:fa_simulator/widget/components/extension/color_extension.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
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
  colorScheme: lightColorScheme,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white.withOpa(0.5),
    ),
  ),
);

ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: _primaryColor,
  onPrimary: Colors.black,
  secondary: _secondaryColor,
  // secondary: Colors.white,
  onSecondary: Color.fromRGBO(157, 157, 157, 1),
  tertiary: _tertiaryColor,
  onTertiary: Colors.black,
  outline: Colors.black,
  // outline: Colors.black,
  outlineVariant: _outlineColor,
  error: Color.fromRGBO(162, 1, 37, 1),
  onError: Colors.white,
  errorContainer: Color.fromRGBO(189, 0, 43, 1),
  surface: _surfaceColor,
  // surface: Colors.white,
  onSurface: _gridPrimalyColor,
  // onSurface: Color(0xFFD0D0D0),
  onSurfaceVariant: _gridSecondaryColor,
  // onSurfaceVariant: Color(0xFFF6F6F6),
  primaryContainer: Color.fromRGBO(255, 255, 255, 1),
);

final textTheme = TextTheme(
  titleLarge: TextStyle(
    color: Colors.black,
    fontSize: 24,
  ),
  titleMedium: TextStyle(
    color: Colors.black,
    fontSize: 18,
  ),
  titleSmall: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),

  labelLarge: TextStyle(
    color: Colors.black,
    fontSize: 20,
  ),
  labelMedium: TextStyle(
    color: Colors.black,
    fontSize: 14,
  ),
  labelSmall: TextStyle(
    color: Colors.black,
    fontSize: 12,
  ),

  // Table data
  bodyLarge: TextStyle(
    fontFamily: 'Roboto Mono',
    color: Colors.black,
    fontSize: 18,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Roboto Mono',
    color: Colors.black,
    fontSize: 14,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Roboto Mono',
    color: Colors.black,
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
const Color _surfaceColor = Color.fromARGB(255, 255, 255, 255);
const Color _primaryColor = Color.fromARGB(255, 244, 244, 244);
const Color _secondaryColor = Color.fromARGB(255, 255, 255, 255);
const Color _tertiaryColor = Color.fromARGB(255, 200, 200, 200);

const Color _gridPrimalyColor = Color.fromARGB(0, 208, 208, 208);
const Color _gridSecondaryColor = Color.fromARGB(0, 246, 246, 246);

const Color _focusColor = Colors.blue;

const Color _outlineColor = Color.fromARGB(255, 218, 218, 218);
