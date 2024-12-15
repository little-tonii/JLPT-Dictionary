import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  final Database _database = DependenciesContainer.getIt.get<Database>();

  HomeTabCubit() : super(HomeTabInitial());

  void loadVocabularies() async {}

  void loadKanjis() async {}

  void loadGrammars() async {}
}
