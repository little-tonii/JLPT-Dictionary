import 'package:equatable/equatable.dart';

abstract class VocabularyTabState extends Equatable {
  const VocabularyTabState();

  @override
  List<Object> get props => [];
}

class VocabularyTabInitial extends VocabularyTabState {}

class VocabularyTabError extends VocabularyTabState {
  final String message;

  const VocabularyTabError(this.message);

  @override
  List<Object> get props => [message];
}
