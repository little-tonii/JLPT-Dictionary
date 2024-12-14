import 'package:jlpt_dictionary/cores/models/kanji_sample.dart';

class YomiModel {
  final int id;
  final String pronounce;
  final int kanjiId;
  final String yomiType;
  final List<KanjiSample> samples;

  YomiModel({
    required this.id,
    required this.pronounce,
    required this.kanjiId,
    required this.yomiType,
    required this.samples,
  });
}
