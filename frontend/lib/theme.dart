import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

ThemeData habitTrackerTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.black01,
    textTheme: TextTheme(
      titleMedium:  TextStyle(
      fontFamily: 'Unbounded',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      letterSpacing: 0,
      height: 1.2,
      color: AppColors.black01,
    ),
      displayLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32.sp,
        letterSpacing: 1.1,
        height: 1.2,
        color: AppColors.black01,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 32.sp,
        letterSpacing: 1.1,
        height: 1.2,
        color: AppColors.purple,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        letterSpacing: -0.4,
        height: 1.2,
        color: AppColors.grey01,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        letterSpacing: 0.2,
        height: 1.2,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        letterSpacing: -0.4,
        height: 1.2,
        color: AppColors.redError,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        side: BorderSide(
          color: AppColors.black01,
          width: 1.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          letterSpacing: -0.4,
          height: 1.2,
          color: AppColors.black01,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.purple,
      selectionHandleColor: AppColors.purple,
    ),
  );
}
