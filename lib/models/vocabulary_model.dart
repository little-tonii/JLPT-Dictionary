import 'package:jlpt_dictionary/constants/db_key.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';

class VocabularyModel {
  final int? id;
  final String kanjiForm;
  final String normalForm;
  final String meaning;
  final JlptLevel jlptLevel;

  VocabularyModel({
    this.id,
    required this.kanjiForm,
    required this.normalForm,
    required this.meaning,
    required this.jlptLevel,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) {
    return VocabularyModel(
      id: json[VocabularyKeys.id],
      kanjiForm: json[VocabularyKeys.kanjiForm],
      normalForm: json[VocabularyKeys.normalForm],
      meaning: json[VocabularyKeys.meaning],
      jlptLevel: JlptLevel.values.firstWhere(
        (e) => e.level == json[VocabularyKeys.jlptLevel],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      VocabularyKeys.kanjiForm: kanjiForm,
      VocabularyKeys.normalForm: normalForm,
      VocabularyKeys.meaning: meaning,
      VocabularyKeys.jlptLevel: jlptLevel.level,
    };
  }
}
