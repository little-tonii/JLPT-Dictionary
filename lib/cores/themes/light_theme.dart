import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/cores/constants/colors.dart';
import 'package:jlpt_dictionary/cores/constants/font_family.dart';

abstract class LightTheme {
  static final theme = ThemeData(
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
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),
      color: AppColors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),
  );
}
