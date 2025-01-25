import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class AppInputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const AppInputTextField({
    super.key,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: context.watch<ThemeCubit>().state
                ? AppColors.black
                : AppColors.white,
          ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.black.withValues(alpha: 0.6)
                  : AppColors.white.withValues(alpha: 0.6),
            ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.watch<ThemeCubit>().state
                ? AppColors.black.withValues(alpha: 0.4)
                : AppColors.white.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.watch<ThemeCubit>().state
                ? AppColors.black
                : AppColors.white,
          ),
        ),
      ),
    );
  }
}
