import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/shared_preferences_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences =
      DependenciesContainer.getIt<SharedPreferences>();

  ThemeCubit() : super(true);

  void init() {
    emit(_sharedPreferences.getBool(SharedPreferencesKey.themeModeKey) ?? true);
  }

  void toggleTheme() {
    if (state == false) {
      emit(true);
      _sharedPreferences.setBool(SharedPreferencesKey.themeModeKey, true);
    } else {
      emit(false);
      _sharedPreferences.setBool(SharedPreferencesKey.themeModeKey, false);
    }
  }
}
