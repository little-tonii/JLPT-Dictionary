import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/routes/app_routes.dart';
import 'package:jlpt_dictionary/themes/dark_theme.dart';
import 'package:jlpt_dictionary/themes/light_theme.dart';

class JlptDictionary extends StatelessWidget {
  const JlptDictionary({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ThemeCubit>().init();
    return MaterialApp(
      theme: context.watch<ThemeCubit>().state
          ? LightTheme.theme
          : DarkTheme.theme,
      routes: AppRoutes.routesGenerator(context),
      initialRoute: AppRoutes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
