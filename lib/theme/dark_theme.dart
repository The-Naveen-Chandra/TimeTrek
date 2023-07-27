import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Color(0xFF2D2F41),
    secondary: Colors.white,
    tertiary: Colors.pink,
  ),
);
