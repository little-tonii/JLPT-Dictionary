import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jlpt_dictionary/cores/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/jlpt_dictionary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependenciesContainer.initDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const JlptDictionary());
}
