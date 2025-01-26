import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/enums/yomi_type.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';
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
      final kanjiIds = results.map((e) => e[KanjiKeys.id]).join(',');
      final yomiResult = await _database.rawQuery("""
        SELECT * FROM ${YomiKeys.tableName}
        WHERE ${YomiKeys.kanjiId} IN ($kanjiIds);
      """);
      final yomiIds = yomiResult.map((e) => e[YomiKeys.id]).join(',');
      final sampleResult = await _database.rawQuery("""
        SELECT * FROM ${KanjiSampleKeys.tableName}
        WHERE ${KanjiSampleKeys.yomiId} IN ($yomiIds);
      """);
      final kanjis = results.map((kanjiRow) {
        final kunyomi = yomiResult
            .where((yomiRow) =>
                yomiRow[YomiKeys.kanjiId] == kanjiRow[KanjiKeys.id] &&
                yomiRow[YomiKeys.yomiType] == YomiType.kunyomi.type)
            .map((yomiRow) {
          final samples = sampleResult
              .where((sampleRow) =>
                  sampleRow[KanjiSampleKeys.yomiId] == yomiRow[YomiKeys.id])
              .toList();
          return {
            ...yomiRow,
            KanjiSampleKeys.tableName: samples,
          };
        }).toList();
        final onyomi = yomiResult
            .where((yomiRow) =>
                yomiRow[YomiKeys.kanjiId] == kanjiRow[KanjiKeys.id] &&
                yomiRow[YomiKeys.yomiType] == YomiType.onyomi.type)
            .map((yomiRow) {
          final samples = sampleResult
              .where((sampleRow) =>
                  sampleRow[KanjiSampleKeys.yomiId] == yomiRow[YomiKeys.id])
              .toList();
          return {
            ...yomiRow,
            KanjiSampleKeys.tableName: samples,
          };
        }).toList();
        return KanjiModel.fromJson({
          ...kanjiRow,
          YomiType.kunyomi.type: kunyomi,
          YomiType.onyomi.type: onyomi,
        });
      }).toList();
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

  void loadMore({required String searchKey}) {}
}
