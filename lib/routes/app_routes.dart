import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/screens/home/home_screen.dart';
import 'package:jlpt_dictionary/screens/onboarding/cubits/onboarding_cubit.dart';
import 'package:jlpt_dictionary/screens/onboarding/onboarding_screen.dart';
import 'package:jlpt_dictionary/screens/splash/cubits/splash_cubit.dart';
import 'package:jlpt_dictionary/screens/splash/splash_screen.dart';

abstract class AppRoutes {
  static String home = "home";
  static String splash = "splash";
  static String onboarding = "onboarding";

  static Map<String, Widget Function(BuildContext)> routesGenerator(
      BuildContext context) {
    return {
      home: (context) => const HomeScreen(),
      splash: (context) => BlocProvider<SplashCubit>(
            create: (context) => DependenciesContainer.getIt.get<SplashCubit>(),
            child: const SplashScreen(),
          ),
      onboarding: (context) => BlocProvider<OnboardingCubit>(
            create: (context) =>
                DependenciesContainer.getIt.get<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
    };
  }
}
