import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  final Database _database = DependenciesContainer.getIt.get<Database>();

  HomeTabCubit() : super(HomeTabInitial());

  void loadCarosel() {
    emit(HomeTabCaroselLoaded(index: Random().nextInt(3) + 1));
  }

  void loadVocabularies() async {
    try {
      final vocabularyCount = <JlptLevel, int>{
        for (final level in JlptLevel.values) level: 0
      };
      final List<Map<String, dynamic>> results = await _database.rawQuery("""
        SELECT ${VocabularyKeys.jlptLevel}, COUNT(*) as count 
        FROM ${VocabularyKeys.tableName} 
        GROUP BY ${VocabularyKeys.jlptLevel};
      """);
      for (final result in results) {
        vocabularyCount[JlptLevel.values.firstWhere(
          (jlptLevel) => jlptLevel.level == result[VocabularyKeys.jlptLevel],
        )] = result['count'];
      }
      emit(HomeTabVocabularyLoaded(vocabularyCount: vocabularyCount));
    } on Exception {
      emit(HomeTabError('có lỗi xảy ra khi tải từ vựng'));
    }
  }

  void loadKanjis() async {
    try {
      final kanjiCount = <JlptLevel, int>{
        for (final level in JlptLevel.values) level: 0
      };
      final List<Map<String, dynamic>> results = await _database.rawQuery("""
        SELECT ${KanjiKeys.jlptLevel}, COUNT(*) as count 
        FROM ${KanjiKeys.tableName} 
        GROUP BY ${KanjiKeys.jlptLevel};
      """);
      for (final result in results) {
        kanjiCount[JlptLevel.values.firstWhere(
          (jlptLevel) => jlptLevel.level == result[KanjiKeys.jlptLevel],
        )] = result['count'];
      }
      emit(HomeTabKanjiLoaded(kanjiCount: kanjiCount));
    } on Exception {
      emit(HomeTabError('có lỗi xảy ra khi tải Hán tự'));
    }
  }

  void loadGrammars() async {}

  void createVocabulary({
    required String kanjiForm,
    required String normalForm,
    required String jlptLevel,
    required String meaning,
  }) async {
    try {
      await _database.insert(
        VocabularyKeys.tableName,
        {
          VocabularyKeys.kanjiForm: kanjiForm,
          VocabularyKeys.normalForm: normalForm,
          VocabularyKeys.jlptLevel: jlptLevel,
          VocabularyKeys.meaning: meaning,
        },
      );
      emit(HomeTabSucces('tạo từ vựng thành công'));
      loadVocabularies();
    } on Exception {
      emit(HomeTabError('có lỗi xảy ra khi tạo từ vựng'));
    }
  }
}
