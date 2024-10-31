import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class FlaconiFonts {
  const FlaconiFonts._();

  static TextTheme textTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: FlaconiColors.darkerText,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: FlaconiColors.darkerText,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: FlaconiColors.darkerText,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: FlaconiColors.darkerText,
      fontSize: 20,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: FlaconiColors.darkerText,
      fontSize: 16,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: FlaconiColors.darkText,
      fontSize: 14,
    ),
    labelLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: FlaconiColors.darkText,
    ),
    labelMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: FlaconiColors.darkText,
    ),
    labelSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: FlaconiColors.lightText,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: FlaconiColors.darkText,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: FlaconiColors.darkerText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.poppins(
      color: FlaconiColors.lightText,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  );
}
