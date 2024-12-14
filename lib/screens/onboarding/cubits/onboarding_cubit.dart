import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/constants/app_file_paths.dart';
import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/constants/shared_preferences_key.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/cores/enums/yomi_type.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final Database _database = DependenciesContainer.getIt<Database>();
  final SharedPreferences _sharedPreferences =
      DependenciesContainer.getIt.get<SharedPreferences>();

  OnboardingCubit() : super(OnboardingInitial());

  void init() async {
    int finishedTask = 0;
    emit(OnBoardingLoading(finishedTask));

    // Load data from json file
    final vocabularyRawData =
        await rootBundle.loadString(AppFilePaths.vocabularyJsonData);
    final vocabularyData = json
        .decode(vocabularyRawData)[VocabularyKeys.tableName] as List<dynamic>;
    final kanjiRawData =
        await rootBundle.loadString(AppFilePaths.kanjiJsonData);
    final kanjiData =
        json.decode(kanjiRawData)[KanjiKeys.tableName] as List<dynamic>;
    final totalTask = vocabularyData.length + kanjiData.length;

    // Insert vocabulary data to database
    for (final vocabulary in vocabularyData) {
      await _database.insert(VocabularyKeys.tableName, {
        VocabularyKeys.id: null,
        VocabularyKeys.kanjiForm: vocabulary[VocabularyKeys.kanjiForm],
        VocabularyKeys.normalForm: vocabulary[VocabularyKeys.normalForm],
        VocabularyKeys.meaning: vocabulary[VocabularyKeys.meaning],
        VocabularyKeys.jlptLevel: vocabulary[VocabularyKeys.jlptLevel],
      });
      finishedTask++;
      emit(OnBoardingLoading(finishedTask * 100 ~/ totalTask));
    }

    // Insert kanji data to database
    for (final kanji in kanjiData) {
      final kanjiId = await _database.insert(KanjiKeys.tableName, {
        KanjiKeys.viet: kanji[KanjiKeys.viet],
        KanjiKeys.kanji: kanji[KanjiKeys.kanji],
        KanjiKeys.jlptLevel: kanji[KanjiKeys.jlptLevel],
        KanjiKeys.numberOfWritingStrokes:
            kanji[KanjiKeys.numberOfWritingStrokes],
      });
      for (final kunyomi in kanji[YomiType.kunyomi.type]) {
        final yomiId = await _database.insert(YomiKeys.tableName, {
          YomiKeys.pronounce: kunyomi[YomiKeys.pronounce],
          YomiKeys.kanjiId: kanjiId,
          YomiKeys.yomiType: YomiType.kunyomi.type,
        });
        for (final sample in kunyomi[KanjiSampleKeys.tableName]) {
          await _database.insert(KanjiSampleKeys.tableName, {
            KanjiSampleKeys.kanjiId: kanjiId,
            KanjiSampleKeys.yomiId: yomiId,
            KanjiSampleKeys.kanjiForm: sample[KanjiSampleKeys.kanjiForm],
            KanjiSampleKeys.normalForm: sample[KanjiSampleKeys.normalForm],
            KanjiSampleKeys.meaning: sample[KanjiSampleKeys.meaning],
          });
        }
      }
      for (final onyomi in kanji[YomiType.onyomi.type]) {
        final yomiId = await _database.insert(YomiKeys.tableName, {
          YomiKeys.pronounce: onyomi[YomiKeys.pronounce],
          YomiKeys.kanjiId: kanjiId,
          YomiKeys.yomiType: YomiType.onyomi.type,
        });
        for (final sample in onyomi[KanjiSampleKeys.tableName]) {
          await _database.insert(KanjiSampleKeys.tableName, {
            KanjiSampleKeys.kanjiId: kanjiId,
            KanjiSampleKeys.yomiId: yomiId,
            KanjiSampleKeys.kanjiForm: sample[KanjiSampleKeys.kanjiForm],
            KanjiSampleKeys.normalForm: sample[KanjiSampleKeys.normalForm],
            KanjiSampleKeys.meaning: sample[KanjiSampleKeys.meaning],
          });
        }
      }
      finishedTask++;
      emit(OnBoardingLoading(finishedTask * 100 ~/ totalTask));
    }

    final isFirstTime =
        _sharedPreferences.getBool(SharedPreferencesKey.isFirstTimeKey) ?? true;
    if (isFirstTime) {
      await _sharedPreferences.setBool(
          SharedPreferencesKey.isFirstTimeKey, false);
    }

    Future.delayed(const Duration(seconds: 1), () {
      emit(OnBoardingLoaded());
    });
  }
}
