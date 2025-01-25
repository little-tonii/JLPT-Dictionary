import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: context.watch<ThemeCubit>().state
            ? WidgetStatePropertyAll(AppColors.black)
            : WidgetStatePropertyAll(AppColors.white),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32,
          ),
        ),
        overlayColor: WidgetStateProperty.all(
          context.watch<ThemeCubit>().state
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.white
                  : AppColors.black,
            ),
      ),
    );
  }
}
