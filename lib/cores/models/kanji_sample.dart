class KanjiSample {
  final int id;
  final int kanjiId;
  final int yomiId;
  final String kanjiForm;
  final String normalForm;
  final String meaning;

  KanjiSample({
    required this.id,
    required this.kanjiId,
    required this.yomiId,
    required this.kanjiForm,
    required this.normalForm,
    required this.meaning,
  });

  factory KanjiSample.fromJson(Map<String, dynamic> json) {
    return KanjiSample(
      id: json['id'],
      kanjiId: json['kanji_id'],
      yomiId: json['yomi_id'],
      kanjiForm: json['kanji_form'],
      normalForm: json['normal_form'],
      meaning: json['meaning'],
    );
  }
}
