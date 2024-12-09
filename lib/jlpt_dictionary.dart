import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/cores/routes/app_routes.dart';

class JlptDictionary extends StatelessWidget {
  const JlptDictionary({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => DependenciesContainer.getIt<ThemeCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: context.watch<ThemeCubit>().state
            ? ThemeData.light()
            : ThemeData.dark(),
        routes: AppRoutes.routesGenerator(context),
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
