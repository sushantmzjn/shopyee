import 'package:flutter/material.dart';
//light mode

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      surfaceTintColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade400,
      // inversePrimary: Colors.grey.shade800,
    ));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.grey.shade900,
      surfaceTintColor: Colors.grey.shade900,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      // inversePrimary: Colors.grey.shade300,
    ));
