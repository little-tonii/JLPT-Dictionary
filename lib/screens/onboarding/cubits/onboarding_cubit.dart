import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/constants/app_file_paths.dart';
import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_state.dart';
import 'package:sqflite/sqflite.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final Database _database = DependenciesContainer.getIt<Database>();

  OnboardingCubit() : super(OnboardingInitial());

  void init() async {
    emit(const OnBoardingLoading(0));
    final vocabularyRawData =
        await rootBundle.loadString(AppFilePaths.vocabularyJsonData);
    final vocabularyData = json
        .decode(vocabularyRawData)[VocabularyKeys.tableName] as List<dynamic>;
    log(vocabularyData.length.toString());
    final kanjiRawData =
        await rootBundle.loadString(AppFilePaths.kanjiJsonData);
    final kanjiData =
        json.decode(kanjiRawData)[KanjiKeys.tableName] as List<dynamic>;
    log(kanjiData.length.toString());
    emit(OnBoardingLoaded());
    // emit(const OnBoardingLoading(0));
    // Future.delayed(const Duration(seconds: 1), () {
    //   emit(const OnBoardingLoading(15));
    // });
    // Future.delayed(const Duration(seconds: 2), () {
    //   emit(const OnBoardingLoading(30));
    // });
    // Future.delayed(const Duration(seconds: 3), () {
    //   emit(const OnBoardingLoading(45));
    // });
    // Future.delayed(const Duration(seconds: 4), () {
    //   emit(const OnBoardingLoading(60));
    // });
    // Future.delayed(const Duration(seconds: 5), () {
    //   emit(const OnBoardingLoading(75));
    // });
    // Future.delayed(const Duration(seconds: 6), () {
    //   emit(const OnBoardingLoading(90));
    // });
    // Future.delayed(const Duration(seconds: 7), () {
    //   emit(const OnBoardingLoading(100));
    //   Future.delayed(const Duration(seconds: 1), () {
    //     emit(OnBoardingLoaded());
    //   });
    // });
  }
}
