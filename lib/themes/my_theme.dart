import 'package:flutter/material.dart';

class MyTheme {
  static Color primary = Colors.blueGrey;
  static final ThemeData mythem = ThemeData(
    primaryColor: primary,
    brightness: Brightness.light,
    fontFamily: 'Releway',
    appBarTheme: AppBarTheme(color: primary, elevation: 20),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
  );
}
