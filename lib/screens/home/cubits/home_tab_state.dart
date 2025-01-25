import 'package:equatable/equatable.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';

abstract class HomeTabState extends Equatable {
  const HomeTabState();

  @override
  List<Object> get props => [];
}

class HomeTabInitial extends HomeTabState {}

class HomeTabCaroselLoaded extends HomeTabState {
  final int index;

  const HomeTabCaroselLoaded({required this.index});

  @override
  List<Object> get props => [index];
}

class HomeTabVocabularyLoaded extends HomeTabState {
  final Map<JlptLevel, int> vocabularyCount;

  const HomeTabVocabularyLoaded({required this.vocabularyCount});

  @override
  List<Object> get props => [vocabularyCount];
}

class HomeTabKanjiLoaded extends HomeTabState {
  final Map<JlptLevel, int> kanjiCount;

  const HomeTabKanjiLoaded({required this.kanjiCount});

  @override
  List<Object> get props => [kanjiCount];
}

class HomeTabGrammarLoaded extends HomeTabState {
  final Map<JlptLevel, int> grammarCount;

  const HomeTabGrammarLoaded({required this.grammarCount});

  @override
  List<Object> get props => [grammarCount];
}

class HomeTabError extends HomeTabState {
  final String message;

  const HomeTabError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeTabSucces extends HomeTabState {
  final String message;

  const HomeTabSucces(this.message);

  @override
  List<Object> get props => [message];
}
