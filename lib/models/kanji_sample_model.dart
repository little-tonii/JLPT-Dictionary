import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/enums/yomi_type.dart';

class KanjiSampleModel {
  final int? id;
  final int kanjiId;
  final String kanjiForm;
  final String normalForm;
  final String meaning;
  final YomiType yomiType;

  KanjiSampleModel({
    this.id,
    required this.kanjiId,
    required this.yomiType,
    required this.kanjiForm,
    required this.normalForm,
    required this.meaning,
  });

  factory KanjiSampleModel.fromJson(Map<String, dynamic> json) {
    return KanjiSampleModel(
      id: json[KanjiSampleKeys.kanjiId],
      kanjiId: json[KanjiSampleKeys.kanjiId],
      yomiType: YomiType.values.firstWhere(
        (e) => e.type == json[KanjiSampleKeys.yomiType],
      ),
      kanjiForm: json[KanjiSampleKeys.kanjiForm],
      normalForm: json[KanjiSampleKeys.normalForm],
      meaning: json[KanjiSampleKeys.meaning],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KanjiSampleKeys.kanjiId: kanjiId,
      KanjiSampleKeys.yomiType: yomiType.type,
      KanjiSampleKeys.kanjiForm: kanjiForm,
      KanjiSampleKeys.normalForm: normalForm,
      KanjiSampleKeys.meaning: meaning,
    };
  }
}
