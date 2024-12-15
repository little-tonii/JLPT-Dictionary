import 'package:get_it/get_it.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_cubit.dart';
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
        onCreate: (db, version) async {
          await db.execute(JlptDictionaryDatabase.createKanjiTableQuery);
          await db.execute(JlptDictionaryDatabase.createYomiTableQuery);
          await db.execute(JlptDictionaryDatabase.createKanjiSampleTableQuery);
          await db.execute(JlptDictionaryDatabase.createVocabularyTableQuery);
        },
      ),
    );
    getIt.registerSingleton(await SharedPreferences.getInstance());
    getIt.registerFactory(() => ThemeCubit());
    getIt.registerFactory(() => SplashCubit());
    getIt.registerFactory(() => OnboardingCubit());
    getIt.registerFactory(() => HomeTabCubit());
  }
}
