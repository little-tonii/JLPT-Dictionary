import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/models/vocabulary_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class VocabularyTabCubit extends Cubit<VocabularyTabState> {
  VocabularyTabCubit() : super(VocabularyTabInitial());
  final Database _database = DependenciesContainer.getIt<Database>();

  void loadVocabularies({String? searchKey, required int page}) async {
    try {
      List<Map<String, dynamic>> results;
      if (searchKey != null) {
        results = await _database.rawQuery("""
          SELECT * FROM ${VocabularyKeys.tableName}
          WHERE ${VocabularyKeys.kanjiForm} LIKE '%$searchKey%'
          OR ${VocabularyKeys.normalForm} LIKE '%$searchKey%'
          OR ${VocabularyKeys.meaning} LIKE '%$searchKey%'
          LIMIT 20 OFFSET ${(page - 1) * 20};
        """);
      } else {
        results = await _database.rawQuery("""
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

  void updateVocabulary({
    required String kanjiForm,
    required String normalForm,
    required String meaning,
    required int id,
    required String jlptLevel,
  }) async {
    final currentState = state;
    if (currentState is VocabularyTabLoaded) {
      final vocabularies = currentState.vocabularies;
      final index = vocabularies.indexWhere((v) => v.id == id);
      if (index != -1) {
        try {
          final result = await _database.rawUpdate("""
            UPDATE ${VocabularyKeys.tableName}
            SET ${VocabularyKeys.kanjiForm} = '$kanjiForm',
                ${VocabularyKeys.normalForm} = '$normalForm',
                ${VocabularyKeys.meaning} = '$meaning',
                ${VocabularyKeys.jlptLevel} = '$jlptLevel'
            WHERE ${VocabularyKeys.id} = $id;
          """);
          if (result == 0) {
            emit(VocabularyTabSaveFailed(
                message: "Có lỗi xảy ra khi cập nhật từ vựng"));
            return;
          }
          emit(VocabularyTabSaveSuccess(
            message: "cập nhật từ vựng thành công",
          ));
          vocabularies[index] = vocabularies[index].copyWith(
            kanjiForm: kanjiForm,
            normalForm: normalForm,
            meaning: meaning,
            jlptLevel: JlptLevel.values.firstWhere(
              (e) =>
                  e.level.split(".").last.toString().toUpperCase() == jlptLevel,
            ),
          );
          emit(VocabularyTabLoaded(
            vocabularies: vocabularies,
            page: currentState.page,
            hasReachedMax: currentState.hasReachedMax,
          ));
        } on Exception {
          emit(VocabularyTabSaveFailed(
              message: "có lỗi xảy ra khi cập nhật từ vựng"));
        }
      }
    }
  }

  void deleteVocaulary({required int id}) async {
    final currentState = state;
    if (currentState is VocabularyTabLoaded) {
      final vocabularies = currentState.vocabularies;
      final index = vocabularies.indexWhere((v) => v.id == id);
      if (index != -1) {
        try {
          final result = await _database.rawDelete("""
            DELETE FROM ${VocabularyKeys.tableName}
            WHERE ${VocabularyKeys.id} = $id;
          """);
          if (result == 0) {
            emit(VocabularyTabDeleteFailed(
                message: "Có lỗi xảy ra khi xóa từ vựng"));
            return;
          }
          emit(VocabularyTabDeleteSuccess(
            message: "Xóa từ vựng thành công",
          ));
          vocabularies.removeAt(index);
          emit(VocabularyTabLoaded(
            vocabularies: vocabularies,
            page: currentState.page,
            hasReachedMax: currentState.hasReachedMax,
          ));
        } on Exception {
          emit(VocabularyTabDeleteFailed(
              message: "Có lỗi xảy ra khi xóa từ vựng"));
        }
      }
    }
  }
}
