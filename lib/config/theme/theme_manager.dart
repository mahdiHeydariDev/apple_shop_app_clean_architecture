import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeData = ThemeMode.dark;
  ThemeMode get themeMode => _themeData;
  toggleTheme(bool isDark) {
    _themeData = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
