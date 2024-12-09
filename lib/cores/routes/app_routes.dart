import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/screens/home/home_screen.dart';

abstract class AppRoutes {
  static String home = "home";
  static String splash = "splash";

  static Map<String, Widget Function(BuildContext)> routesGenerator(
      BuildContext context) {
    return {
      home: (context) => const HomeScreen(),
    };
  }
}
