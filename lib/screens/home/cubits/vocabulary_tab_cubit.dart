import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_state.dart';

class VocabularyTabCubit extends Cubit<VocabularyTabState> {
  VocabularyTabCubit() : super(VocabularyTabInitial());

  void loadVocabularies({String? searchKey}) {
    try {

    } on Exception {
      emit(VocabularyTabError('có lỗi xảy ra khi tải từ vựng'));
    }
  }
}
