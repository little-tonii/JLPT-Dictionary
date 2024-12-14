import 'package:get_it/get_it.dart';
import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_cubit.dart';
import 'package:jlpt_dictionary/screens/splash/cubits/splash_cubit.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class DependenciesContainer {
  static final getIt = GetIt.instance;

  static Future<void> initDependencies() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, JlptDictionaryDatabase.databaseName);
    getIt.registerSingleton(
      await openDatabase(
        path,
        version: JlptDictionaryDatabase.databaseVersion,
        onCreate: (db, version) {
          db.execute(JlptDictionaryDatabase.createKanjiTableQuery);
          db.execute(JlptDictionaryDatabase.createYomiTableQuery);
          db.execute(JlptDictionaryDatabase.createKanjiSampleTableQuery);
        },
      ),
    );
    getIt.registerSingleton(await SharedPreferences.getInstance());
    getIt.registerFactory(() => ThemeCubit());
    getIt.registerFactory(() => SplashCubit());
    getIt.registerFactory(() => OnboardingCubit());
  }
}
