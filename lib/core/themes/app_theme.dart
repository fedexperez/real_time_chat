import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryLight = const Color.fromARGB(255, 9, 92, 191);
  static Color primaryDark = const Color.fromARGB(255, 3, 23, 70);

  static final ThemeData ligthTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryLight,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryDark,
  );
}
