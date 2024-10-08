import 'package:flutter/material.dart';

ThemeData habitTrackerTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFCFCFF),
    primaryColor: const Color(0xFF28282B),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1.1,
        height: 1.3,
        color: Color(0xFF28282B),
      ),
      displayMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1.1,
        height: 1.3,
        color: Color(0xFF734CC6),
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: -0.4,
        height: 1.3,
        color: Color(0xFFA9ACC8),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.2,
        height: 1.3,
        color: Color(0xFFFCFCFF),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color(0xFF28282B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: -0.4,
          height: 1.3,
          color: Color(0xFF28282B),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        side: const BorderSide(
          color: Color(0xFF28282B),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: -0.4,
          height: 1.3,
          color: Color(0xFF28282B),
        ),
      ),
    ),
  );
}
