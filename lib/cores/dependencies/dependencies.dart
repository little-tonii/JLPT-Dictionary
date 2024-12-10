import 'package:get_it/get_it.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_cubit.dart';
import 'package:jlpt_dictionary/screens/splash/cubits/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DependenciesContainer {
  static final getIt = GetIt.instance;

  static Future<void> initDependencies() async {
    getIt.registerSingleton(await SharedPreferences.getInstance());
    getIt.registerFactory(() => ThemeCubit());
    getIt.registerFactory(() => SplashCubit());
    getIt.registerFactory(() => OnboardingCubit());
  }
}
