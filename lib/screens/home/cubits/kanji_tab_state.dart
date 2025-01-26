import 'package:equatable/equatable.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';
import 'package:jlpt_dictionary/models/kanji_sample_model.dart';
import 'package:jlpt_dictionary/models/yomi_model.dart';

abstract class KanjiTabState extends Equatable {
  const KanjiTabState();

  @override
  List<Object> get props => [];
}

class KanjiTabInitial extends KanjiTabState {}

class KanjiTabError extends KanjiTabState {
  final String message;

  const KanjiTabError({required this.message});

  @override
  List<Object> get props => [message];
}

class KanjiTabSuccess extends KanjiTabState {
  final String message;

  const KanjiTabSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class KanjiTabLoaded extends KanjiTabState {
  final List<KanjiModel> kanjis;
  final int page;
  final bool hasReachedMax;

  const KanjiTabLoaded({
    required this.hasReachedMax,
    required this.kanjis,
    required this.page,
  });

  @override
  List<Object> get props => [hasReachedMax, kanjis, page];
}

class KanjiTabYomiLoaded extends KanjiTabState {
  final List<YomiModel> yomis;

  const KanjiTabYomiLoaded({required this.yomis});

  @override
  List<Object> get props => [yomis];
}

class KanjiTabKanjiSampleLoaded extends KanjiTabState {
  final List<KanjiSampleModel> samples;
  final int kanjiId;
  final int yomiId;

  const KanjiTabKanjiSampleLoaded(
      {required this.samples, required this.kanjiId, required this.yomiId});

  @override
  List<Object> get props => [samples, kanjiId, yomiId];
}
