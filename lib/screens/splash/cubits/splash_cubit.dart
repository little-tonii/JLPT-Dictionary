import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/shared_preferences_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences =
      DependenciesContainer.getIt.get<SharedPreferences>();

  SplashCubit() : super(true);

  void init() {
    final isFirstTime =
        _sharedPreferences.getBool(SharedPreferencesKey.isFirstTimeKey) ?? true;
    emit(isFirstTime);
  }
}
