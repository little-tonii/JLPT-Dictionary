import 'package:equatable/equatable.dart';
import 'package:jlpt_dictionary/models/vocabulary_model.dart';

abstract class VocabularyTabState extends Equatable {
  const VocabularyTabState();

  @override
  List<Object> get props => [];
}

class VocabularyTabInitial extends VocabularyTabState {}

class VocabularyTabLoaded extends VocabularyTabState {
  final List<VocabularyModel> vocabularies;
  final int page;
  final bool hasReachedMax;

  const VocabularyTabLoaded({
    required this.hasReachedMax,
    required this.vocabularies,
    required this.page,
  });

  @override
  List<Object> get props => [hasReachedMax, vocabularies, page];
}

class VocabularyTabError extends VocabularyTabState {
  final String message;

  const VocabularyTabError(this.message);

  @override
  List<Object> get props => [message];
}

class VocabularyTabSaveSuccess extends VocabularyTabState {
  final String message;

  const VocabularyTabSaveSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class VocabularyTabSaveFailed extends VocabularyTabState {
  final String message;

  const VocabularyTabSaveFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class VocabularyTabDeleteSuccess extends VocabularyTabState {
  final String message;

  const VocabularyTabDeleteSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class VocabularyTabDeleteFailed extends VocabularyTabState {
  final String message;

  const VocabularyTabDeleteFailed({required this.message});

  @override
  List<Object> get props => [message];
}
