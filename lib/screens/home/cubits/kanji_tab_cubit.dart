import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_state.dart';
import 'package:sqflite/sqflite.dart';

class KanjiTabCubit extends Cubit<KanjiTabState> {
  final Database _database = DependenciesContainer.getIt.get<Database>();

  KanjiTabCubit() : super(KanjiTabInitial());

  void loadKanjis({String? searchKey, required int page}) async {}

  void loadMore({required String searchKey}) {}

  
}
