import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor:
          context.watch<ThemeCubit>().state ? AppColors.white : AppColors.black,
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
  }
}
