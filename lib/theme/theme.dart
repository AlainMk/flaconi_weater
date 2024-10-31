import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/fonts.dart';
import 'package:flutter/material.dart';

/// The principle base theme of bof client and business app
class FlaconiTheme {
  /// Light default theme color scheme
  static ThemeData light() {
    return ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
        primary: FlaconiColors.primary,
        secondary: FlaconiColors.secondary,
        error: FlaconiColors.red,
        surface: FlaconiColors.white,
      ),
      primaryColor: FlaconiColors.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: FlaconiColors.white,
        elevation: 0,
        foregroundColor: FlaconiColors.darkerText,
      ),
      scaffoldBackgroundColor: FlaconiColors.white,
      textTheme: FlaconiFonts.textTheme,
      useMaterial3: false,
    );
  }
}
