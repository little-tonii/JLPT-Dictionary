import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/cores/models/yomi_model.dart';
import 'package:jlpt_dictionary/cores/enums/yomi_type.dart';

class KanjiModel {
  final int? id;
  final String viet;
  final String kanji;
  final JlptLevel jlptLevel;
  final int numberOfWritingStrokes;
  final List<YomiModel> kunyomis;
  final List<YomiModel> onyomis;

  KanjiModel({
    this.id,
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
      jlptLevel: JlptLevel.values.firstWhere(
        (e) => e.level == json[KanjiKeys.jlptLevel],
      ),
      numberOfWritingStrokes: json[KanjiKeys.numberOfWritingStrokes],
      kunyomis: (json[YomiType.kunyomi.type] as List<Map<String, dynamic>>)
          .map((e) => YomiModel.fromJson(e))
          .toList(),
      onyomis: (json[YomiType.onyomi.type] as List<Map<String, dynamic>>)
          .map((e) => YomiModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KanjiKeys.viet: viet,
      KanjiKeys.kanji: kanji,
      KanjiKeys.jlptLevel: jlptLevel.level,
      KanjiKeys.numberOfWritingStrokes: numberOfWritingStrokes,
    };
  }
}
