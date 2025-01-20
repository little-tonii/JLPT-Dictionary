import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/models/vocabulary_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class VocabularyTabCubit extends Cubit<VocabularyTabState> {
  VocabularyTabCubit() : super(VocabularyTabInitial());
  final Database database = DependenciesContainer.getIt<Database>();

  void loadVocabularies({String? searchKey, required int page}) async {
    try {
      List<Map<String, dynamic>> results;
      if (searchKey != null) {
        results = await database.rawQuery("""
          SELECT * FROM ${VocabularyKeys.tableName}
          WHERE ${VocabularyKeys.kanjiForm} LIKE '%$searchKey%'
          OR ${VocabularyKeys.normalForm} LIKE '%$searchKey%'
          OR ${VocabularyKeys.meaning} LIKE '%$searchKey%'
          LIMIT 20 OFFSET ${(page - 1) * 20};
        """);
      } else {
        results = await database.rawQuery("""
          SELECT * FROM ${VocabularyKeys.tableName}
          LIMIT 20 OFFSET ${(page - 1) * 20};
        """);
      }
      final vocabularies =
          results.map((e) => VocabularyModel.fromJson(e)).toList();
      if (state is VocabularyTabLoaded && page > 1) {
        final currentState = state as VocabularyTabLoaded;
        emit(
          VocabularyTabLoaded(
            hasReachedMax: vocabularies.length < 20,
            vocabularies: [...currentState.vocabularies, ...vocabularies],
            page: page,
          ),
        );
      } else {
        emit(VocabularyTabLoaded(
          vocabularies: vocabularies,
          page: page,
          hasReachedMax: vocabularies.length < 20,
        ));
      }
    } on Exception {
      emit(VocabularyTabError('có lỗi xảy ra khi tải từ vựng'));
    }
  }

  void loadMore({required String searchKey}) {
    if (state is VocabularyTabLoaded) {
      final currentState = state as VocabularyTabLoaded;
      if (!currentState.hasReachedMax) {
        loadVocabularies(
          searchKey: searchKey == '' ? null : searchKey,
          page: currentState.page + 1,
        );
      }
    }
  }
}
