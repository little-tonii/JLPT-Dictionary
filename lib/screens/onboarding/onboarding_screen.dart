import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/routes/app_routes.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_cubit.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_state.dart';

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
            const CircularProgressIndicator(),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<OnboardingCubit, OnboardingState>(
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
