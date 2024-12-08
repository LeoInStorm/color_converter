import 'package:flutter/material.dart';

final tema = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(250, 248, 36, 16),
    titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(250, 248, 36, 16),
  )
);