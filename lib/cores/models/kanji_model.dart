import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/enums/jlpt_level_enum.dart';
import 'package:jlpt_dictionary/cores/models/yomi_model.dart';
import 'package:jlpt_dictionary/cores/enums/yomi_type_enum.dart';

class KanjiModel {
  final int id;
  final String viet;
  final String kanji;
  final JlptLevelEnum jlptLevel;
  final int numberOfWritingStrokes;
  final List<YomiModel> kunyomis;
  final List<YomiModel> onyomis;

  KanjiModel({
    required this.id,
    required this.viet,
    required this.kanji,
    required this.jlptLevel,
    required this.numberOfWritingStrokes,
    required this.kunyomis,
    required this.onyomis,
  });

  factory KanjiModel.fromJson(Map<String, dynamic> json) {
    return KanjiModel(
      id: json[KanjiKeys.id],
      viet: json[KanjiKeys.viet],
      kanji: json[KanjiKeys.kanji],
      jlptLevel: JlptLevelEnum.values.firstWhere(
        (e) => e.jlptLevel == json[KanjiKeys.jlptLevel],
      ),
      numberOfWritingStrokes: json[KanjiKeys.numberOfWritingStrokes],
      kunyomis:
          (json[YomiTypeEnum.kunyomi.yomiType] as List<Map<String, dynamic>>)
              .map((e) => YomiModel.fromJson(e))
              .toList(),
      onyomis:
          (json[YomiTypeEnum.onyomi.yomiType] as List<Map<String, dynamic>>)
              .map((e) => YomiModel.fromJson(e))
              .toList(),
    );
  }
}
