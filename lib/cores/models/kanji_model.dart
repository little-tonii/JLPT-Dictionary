import 'package:jlpt_dictionary/cores/models/yomi_model.dart';

class KanjiModel {
  final int id;
  final String viet;
  final String kanji;
  final String jlptLevel;
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
}
