import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/helpers/toast_helper.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_state.dart';
import 'package:jlpt_dictionary/screens/home/widgets/vocabulary/vocabulary_item.dart';
import 'package:jlpt_dictionary/widgets/app_search_text_field.dart';

class VocabularyTab extends StatefulWidget {
  const VocabularyTab({super.key});

  @override
  State<VocabularyTab> createState() => _VocabularyTabState();
}

class _VocabularyTabState extends State<VocabularyTab> {
  late ScrollController _scrollController;
  String searchKey = '';

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom()) {
      context.read<VocabularyTabCubit>().loadMore(searchKey: searchKey);
    }
  }

  bool _isBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: AppSearchTextField(
                  onSubmit: (value) {
                    searchKey = value;
                    context
                        .read<VocabularyTabCubit>()
                        .loadVocabularies(searchKey: value, page: 1);
                  },
                  onChanged: (value) {
                    searchKey = value;
                  },
                  hintText: 'Tìm kiếm từ vựng',
                ),
              ),
              Expanded(
                child: BlocConsumer<VocabularyTabCubit, VocabularyTabState>(
                  buildWhen: (previous, current) =>
                      current is VocabularyTabLoaded ||
                      current is VocabularyTabInitial,
                  builder: (context, state) {
                    if (state is VocabularyTabInitial) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.black,
                        ),
                      );
                    }
                    if (state is VocabularyTabLoaded) {
                      if (state.vocabularies.isEmpty) {
                        return Center(
                          child: Text(
                            'Không có kết quả nào',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < state.vocabularies.length) {
                            return VocabularyItem(
                              vocabulary: state.vocabularies[index],
                              index: index,
                            );
                          }
                          return SizedBox();
                        },
                        controller: _scrollController,
                        itemCount: state.vocabularies.length + 1,
                      );
                    }
                    return Center(
                      child: Text(
                        'Không có từ vựng nào',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is VocabularyTabError) {
                      ToastHelper.showError(context, state.message);
                    }
                    if (state is VocabularyTabSaveSuccess) {
                      ToastHelper.showSuccess(context, state.message);
                    }
                    if (state is VocabularyTabSaveFailed) {
                      ToastHelper.showError(context, state.message);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
