import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class MainTheme {
  static ThemeData light = ThemeData(
    fontFamily: 'shabnamlight',
    brightness: Brightness.light,
    scaffoldBackgroundColor: ConstantsColors.background,
    cardColor: Colors.white,
    shadowColor: ConstantsColors.grey,
  );
  static ThemeData dark = ThemeData(
    fontFamily: 'shabnamlight',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: const ColorScheme.dark(),
    cardColor: Colors.grey[800],
    shadowColor: Colors.grey[800],
  );
}
