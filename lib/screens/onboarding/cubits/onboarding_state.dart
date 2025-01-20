import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnBoardingLoading extends OnboardingState {
  final int percent;

  const OnBoardingLoading(this.percent);

  @override
  List<Object> get props => [percent];
}

class OnBoardingLoaded extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object> get props => [message];
}
