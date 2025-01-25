import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/constants/font_family.dart';

abstract class LightTheme {
  static final theme = ThemeData(
    primaryColor: AppColors.black,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.black.withValues(alpha: 0.2),
      selectionHandleColor: AppColors.black.withValues(alpha: 0.8),
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: AppColors.black,
        fontFamily: FontFamily.mPlus2,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.black,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      shape: CircleBorder(),
    ),
  );
}
