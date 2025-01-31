import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';
import 'package:jlpt_dictionary/models/kanji_sample_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class KanjiTabCubit extends Cubit<KanjiTabState> {
  final Database _database = DependenciesContainer.getIt<Database>();

  KanjiTabCubit() : super(KanjiTabInitial());

  void loadKanjis({String? searchKey, required int page}) async {
    try {
      List<Map<String, dynamic>> results;
      if (searchKey != null) {
        results = await _database.rawQuery("""
          SELECT * FROM ${KanjiKeys.tableName}
          WHERE ${KanjiKeys.kanji} LIKE '%$searchKey%'
          OR ${KanjiKeys.viet} LIKE '%$searchKey%'
          LIMIT 20 OFFSET ${(page - 1) * 20};
        """);
      } else {
        results = await _database.rawQuery("""
          SELECT * FROM ${KanjiKeys.tableName}
          LIMIT 20 OFFSET ${(page - 1) * 20};
        """);
      }
      final kanjis = results.map((row) => KanjiModel.fromJson(row)).toList();
      if (state is KanjiTabLoaded && page > 1) {
        final currentState = state as KanjiTabLoaded;
        emit(
          KanjiTabLoaded(
            hasReachedMax: kanjis.length < 20,
            kanjis: [...currentState.kanjis, ...kanjis],
            page: page,
          ),
        );
      } else {
        emit(KanjiTabLoaded(
          kanjis: kanjis,
          page: page,
          hasReachedMax: kanjis.length < 20,
        ));
      }
    } on Exception {
      emit(KanjiTabError(message: 'có lỗi xảy ra khi tải kanji'));
    }
  }

  void loadSamples({required int kanjiId, required int yomiId}) async {
    // try {
    //   final results = await _database.rawQuery("""
    //     SELECT * FROM ${KanjiSampleKeys.tableName}
    //     WHERE ${KanjiSampleKeys.kanjiId} = $kanjiId
    //     AND ${KanjiSampleKeys.yomiId} = $yomiId;
    //   """);
    //   final samples =
    //       results.map((row) => KanjiSampleModel.fromJson(row)).toList();
    //   emit(KanjiTabKanjiSampleLoaded(
    //       samples: samples, kanjiId: kanjiId, yomiId: yomiId));
    // } on Exception {
    //   emit(KanjiTabError(message: 'có lỗi xảy ra khi tải ví dụ mẫu'));
    // }
  }

  void loadMore({required String searchKey}) {}
}
