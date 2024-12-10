import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/cores/routes/app_routes.dart';
import 'package:jlpt_dictionary/screens/splash/cubits/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.read<SplashCubit>().init();
      }
    });
    return Scaffold(
      body: BlocListener<SplashCubit, bool>(
        listener: (context, state) {
          if (state == true) {
            Navigator.of(context).popAndPushNamed(AppRoutes.onboarding);
          } else {
            Navigator.of(context).popAndPushNamed(AppRoutes.home);
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
