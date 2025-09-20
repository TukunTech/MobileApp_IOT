import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF252525),
    primaryColor: const Color(0xFF122C4F),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.bowlbyOneSc(
        fontSize: 32,
        color: const Color(0xFFF0E8D5),
      ),
      headlineMedium: GoogleFonts.josefinSans(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFF0E8D5),
      ),
      bodyMedium: GoogleFonts.darkerGrotesque(
        fontSize: 16,
        color: const Color(0xFFB0B0B0),
      ),
      bodySmall: GoogleFonts.darkerGrotesque(
        fontSize: 14,
        color: const Color(0xFFB0B0B0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6386AC), // azul grisáceo
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
