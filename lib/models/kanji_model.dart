import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';

class KanjiModel {
  final int? id;
  final String viet;
  final String kanji;
  final JlptLevel jlptLevel;
  final int numberOfWritingStrokes;

  KanjiModel({
    this.id,
    required this.viet,
    required this.kanji,
    required this.jlptLevel,
    required this.numberOfWritingStrokes,
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
