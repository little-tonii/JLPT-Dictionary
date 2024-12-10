import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/jlpt_dictionary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependenciesContainer.initDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DependenciesContainer.getIt.get<ThemeCubit>()..init(),
        ),
      ],
      child: const JlptDictionary(),
    ),
  );
}
