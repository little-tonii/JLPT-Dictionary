import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/helpers/toast_helper.dart';
import 'package:jlpt_dictionary/routes/app_routes.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_cubit.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_state.dart';
import 'package:jlpt_dictionary/widgets/app_loader.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OnboardingCubit>().init();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Đang khởi tạo",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            AppLoader(),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<OnboardingCubit, OnboardingState>(
              buildWhen: (previous, current) =>
                  current is OnBoardingLoading || current is OnboardingInitial,
              builder: (context, state) {
                if (state is OnBoardingLoading) {
                  return Text(
                    "${state.percent}%",
                    style: Theme.of(context).textTheme.displayMedium,
                  );
                }
                return const SizedBox();
              },
              listener: (BuildContext context, OnboardingState state) {
                if (state is OnBoardingLoaded) {
                  Navigator.of(context).popAndPushNamed(AppRoutes.home);
                }
                if (state is OnboardingError) {
                  ToastHelper.showError(context, state.message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
