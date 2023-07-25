import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: const Color(0xFF2D2F41),
    secondary: Colors.white,
    tertiary: Colors.pink,
  ),
);
