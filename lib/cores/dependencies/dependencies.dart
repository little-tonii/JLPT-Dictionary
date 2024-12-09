import 'package:get_it/get_it.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependenciesContainer {
  static final getIt = GetIt.instance;

  static Future<void> initDependencies() async {
    getIt.registerSingleton(await SharedPreferences.getInstance());
    getIt.registerFactory(() => ThemeCubit());
  }
}
