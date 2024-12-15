import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/jlpt_dictionary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependenciesContainer.initDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    BlocProvider<ThemeCubit>(
      create: (context) => DependenciesContainer.getIt.get<ThemeCubit>(),
      child: const JlptDictionary(),
    ),
  );
}
