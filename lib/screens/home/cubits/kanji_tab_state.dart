import 'package:equatable/equatable.dart';

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
  final List<String> kanjis;
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
