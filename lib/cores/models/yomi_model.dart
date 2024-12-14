import 'package:jlpt_dictionary/cores/constants/db_key.dart';
import 'package:jlpt_dictionary/cores/enums/yomi_type.dart';
import 'package:jlpt_dictionary/cores/models/kanji_sample_model.dart';

class YomiModel {
  final int? id;
  final String pronounce;
  final int kanjiId;
  final YomiType yomiType;
  final List<KanjiSampleModel> samples;

  YomiModel({
    this.id,
    required this.pronounce,
    required this.kanjiId,
    required this.yomiType,
    required this.samples,
  });

  factory YomiModel.fromJson(Map<String, dynamic> json) {
    return YomiModel(
      id: json[YomiKeys.id],
      pronounce: json[YomiKeys.pronounce],
      kanjiId: json[YomiKeys.kanjiId],
      yomiType: YomiType.values.firstWhere(
        (e) => e.type == json[YomiKeys.yomiType],
      ),
      samples: (json[KanjiSampleKeys.tableName] as List<Map<String, dynamic>>)
          .map((e) => KanjiSampleModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      YomiKeys.pronounce: pronounce,
      YomiKeys.kanjiId: kanjiId,
      YomiKeys.yomiType: yomiType.type,
    };
  }
}
