import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color:
          context.watch<ThemeCubit>().state ? AppColors.black : AppColors.white,
    );
  }
}
