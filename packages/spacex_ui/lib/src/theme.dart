import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A collection of the SpaceX app-related theme objects.
class SpacexAppTheme {
  /// The theme of the SpaceX app.
  static ThemeData get theme {
    final base = ThemeData.dark();
    return ThemeData(
      primaryColor: Colors.black,
      textTheme: GoogleFonts.robotoCondensedTextTheme(base.textTheme),
      scaffoldBackgroundColor: Colors.black,
      colorScheme: _colorScheme,
      checkboxTheme: _checkboxTheme,
      textButtonTheme: _textButtonTheme,
      drawerTheme: _drawerTheme,
      listTileTheme: _listTileTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      background: Colors.black,
      onBackground: Colors.white,
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    );
  }

  static CheckboxThemeData get _checkboxTheme {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.black),
      side: const BorderSide(color: Colors.white),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  static DrawerThemeData get _drawerTheme {
    return const DrawerThemeData(
      backgroundColor: Colors.black,
    );
  }

  static ListTileThemeData get _listTileTheme {
    return const ListTileThemeData(
      selectedColor: Colors.grey,
    );
  }
}
