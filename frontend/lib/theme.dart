import 'package:flutter/material.dart';
import 'package:habit_tracker/app_colors.dart';

ThemeData habitTrackerTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor:  AppColors.black01,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1.1,
        height: 1.3,
        color: AppColors.black01,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1.1,
        height: 1.3,
        color: AppColors.purple,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: -0.4,
        height: 1.3,
        color: AppColors.grey01,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.2,
        height: 1.3,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        letterSpacing: -0.4,
        height: 1.3,
        color: AppColors.redError,
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.black01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: -0.4,
          height: 1.3,
          color: AppColors.black01,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        side: const BorderSide(
          color: AppColors.black01,
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
          color: AppColors.black01,
        ),
      ),
    ),
  );
}
