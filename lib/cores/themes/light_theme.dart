import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/cores/constants/colors.dart';

abstract class LightTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
    ),
    fontFamily: 'M_PLUS_2',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(
        color: AppColors.black,
      ),
      color: AppColors.black,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.white,
      secondary: AppColors.black,
    ),
  );
}
