import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/enums/yomi_type.dart';

class YomiModel {
  final int? id;
  final String pronounce;
  final int kanjiId;
  final YomiType yomiType;

  YomiModel({
    this.id,
    required this.pronounce,
    required this.kanjiId,
    required this.yomiType,
  });

  factory YomiModel.fromJson(Map<String, dynamic> json) {
    return YomiModel(
      id: json[YomiKeys.id],
      pronounce: json[YomiKeys.pronounce],
      kanjiId: json[YomiKeys.kanjiId],
      yomiType: YomiType.values.firstWhere(
        (e) => e.type == json[YomiKeys.yomiType],
      ),
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
