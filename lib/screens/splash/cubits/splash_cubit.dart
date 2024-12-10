import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/constants/shared_preferences_key.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences =
      DependenciesContainer.getIt.get<SharedPreferences>();

  SplashCubit() : super(true);

  void init() {
    final isFirstTime =
        _sharedPreferences.getBool(SharedPreferencesKey.isFirstTimeKey) ?? true;
    if (isFirstTime) {
      _sharedPreferences.setBool(SharedPreferencesKey.isFirstTimeKey, false);
    }
    emit(isFirstTime);
  }
}
