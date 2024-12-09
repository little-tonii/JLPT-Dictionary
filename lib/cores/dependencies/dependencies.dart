import 'package:get_it/get_it.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';

class DependenciesContainer {
  static final getIt = GetIt.instance;

  static Future<void> initDependencies() async {
    getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  }
}
