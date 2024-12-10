import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void init() {}
}
