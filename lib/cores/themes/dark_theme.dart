import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/cores/constants/colors.dart';
import 'package:jlpt_dictionary/cores/constants/font_family.dart';

abstract class DarkTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: AppColors.white,
        fontFamily: FontFamily.mPlus2,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.mPlus2,
        color: AppColors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      shape: CircleBorder(),
    ),
  );
}
