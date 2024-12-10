import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/cores/constants/colors.dart';

abstract class DartTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
    ),
    fontFamily: 'M_PLUS_2',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      color: AppColors.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.black,
      secondary: AppColors.white,
    ),
  );
}
