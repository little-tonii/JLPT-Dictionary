import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/constants/shared_preferences_key.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences =
      DependenciesContainer.getIt<SharedPreferences>();

  ThemeCubit() : super(true) {
    emit(_sharedPreferences.getBool(SharedPreferencesKey.themeModeKey) ?? true);
  }

  void toggleTheme() {
    if (state) {
      emit(false);
    } else {
      emit(true);
    }
    _sharedPreferences.setBool(SharedPreferencesKey.themeModeKey, state);
  }
}
