import 'package:equatable/equatable.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';

abstract class HomeTabState extends Equatable {
  const HomeTabState();

  @override
  List<Object> get props => [];
}

class HomeTabInitial extends HomeTabState {}

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
