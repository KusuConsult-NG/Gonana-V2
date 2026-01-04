import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern theme for Gonana app matching HTML design references
/// Primary: Vibrant Green #22c55e / #16a34a
/// Typography: Inter font family
class AppTheme {
  // Modern Color Palette from HTML designs
  static const Color primaryGreen = Color(0xff22c55e);
  static const Color primaryGreenDark = Color(0xff16a34a);
  static const Color secondaryGreen = Color(0xff15803d);

  // Light Mode Colors
  static const Color backgroundLight = Color(0xfff3f4f6);
  static const Color surfaceLight = Color(0xffffffff);
  static const Color borderLight = Color(0xffe5e7eb);
  static const Color textLight = Color(0xff111827);
  static const Color textMutedLight = Color(0xff6b7280);

  // Dark Mode Colors
  static const Color backgroundDark = Color(0xff111827);
  static const Color surfaceDark = Color(0xff1f2937);
  static const Color borderDark = Color(0xff374151);
  static const Color textDark = Color(0xfff3f4f6);
  static const Color textMutedDark = Color(0xff9ca3af);

  // Backward compatibility with existing code
  static const Color primaryColor = primaryGreen;
  static const Color secondaryColor = secondaryGreen;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: secondaryGreen,
      surface: surfaceLight,
      onSurface: textLight,
      error: Color(0xffef4444),
      onError: Colors.white,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: borderLight, width: 1),
      ),
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: textLight,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      iconTheme: const IconThemeData(color: textLight),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xfff9fafb),
      hintStyle: GoogleFonts.inter(color: textMutedLight, fontSize: 14),
      labelStyle: GoogleFonts.inter(
        color: textLight,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffef4444)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: primaryGreen.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xfff3f4f6),
      selectedColor: primaryGreen.withValues(alpha: 0.1),
      deleteIconColor: textMutedLight,
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Typography with Inter font
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textLight,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textLight,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textLight,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMutedLight,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textMutedLight,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: secondaryGreen,
      surface: surfaceDark,
      onSurface: textDark,
      error: Color(0xffef4444),
      onError: Colors.white,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: borderDark, width: 1),
      ),
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      iconTheme: const IconThemeData(color: textDark),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff1f2937),
      hintStyle: GoogleFonts.inter(color: textMutedDark, fontSize: 14),
      labelStyle: GoogleFonts.inter(
        color: textDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffef4444)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: primaryGreen.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xff374151),
      selectedColor: primaryGreen.withValues(alpha: 0.2),
      deleteIconColor: textMutedDark,
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Typography with Inter font
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textDark,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textDark,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMutedDark,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textMutedDark,
      ),
    ),
  );
}
