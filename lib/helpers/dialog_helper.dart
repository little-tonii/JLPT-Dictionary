import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

abstract class DialogHelper {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: context.watch<ThemeCubit>().state
              ? AppColors.white
              : AppColors.black,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          actions: actions,
        );
      },
    );
  }
}
