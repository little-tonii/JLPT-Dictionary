import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final void Function(String) onSubmit;
  final void Function(String) onChanged;

  const SearchTextField({
    required this.onSubmit,
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmit,
      cursorColor:
          context.watch<ThemeCubit>().state ? AppColors.black : AppColors.white,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Icon(
            Icons.search,
            color: context.watch<ThemeCubit>().state
                ? AppColors.black
                : AppColors.white,
          ),
        ),
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.black.withValues(alpha: 0.6)
                  : AppColors.white.withValues(alpha: 0.6),
            ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: context.watch<ThemeCubit>().state
                ? AppColors.black.withValues(alpha: 0.4)
                : AppColors.white.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
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
