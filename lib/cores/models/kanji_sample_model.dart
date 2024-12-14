import 'package:jlpt_dictionary/cores/constants/db_key.dart';

class KanjiSampleModel {
  final int? id;
  final int kanjiId;
  final int yomiId;
  final String kanjiForm;
  final String normalForm;
  final String meaning;

  KanjiSampleModel({
    this.id,
    required this.kanjiId,
    required this.yomiId,
    required this.kanjiForm,
    required this.normalForm,
    required this.meaning,
  });

  factory KanjiSampleModel.fromJson(Map<String, dynamic> json) {
    return KanjiSampleModel(
      id: json[KanjiSampleKeys.kanjiId],
      kanjiId: json[KanjiSampleKeys.kanjiId],
      yomiId: json[KanjiSampleKeys.yomiId],
      kanjiForm: json[KanjiSampleKeys.kanjiForm],
      normalForm: json[KanjiSampleKeys.normalForm],
      meaning: json[KanjiSampleKeys.meaning],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KanjiSampleKeys.kanjiId: kanjiId,
      KanjiSampleKeys.yomiId: yomiId,
      KanjiSampleKeys.kanjiForm: kanjiForm,
      KanjiSampleKeys.normalForm: normalForm,
      KanjiSampleKeys.meaning: meaning,
    };
  }
}
