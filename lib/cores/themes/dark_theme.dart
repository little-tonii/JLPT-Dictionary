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
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      color: AppColors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
  );
}
