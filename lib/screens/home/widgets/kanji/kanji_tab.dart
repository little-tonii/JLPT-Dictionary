import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/helpers/toast_helper.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_state.dart';
import 'package:jlpt_dictionary/screens/home/widgets/kanji/kanji_item.dart';
import 'package:jlpt_dictionary/widgets/app_loader.dart';
import 'package:jlpt_dictionary/widgets/app_search_text_field.dart';

class KanjiTab extends StatefulWidget {
  final HomeTabCubit homeTabCubit;

  const KanjiTab({super.key, required this.homeTabCubit});

  @override
  State<KanjiTab> createState() => _KanjiTabState();
}

class _KanjiTabState extends State<KanjiTab> {
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
      context.read<KanjiTabCubit>().loadMore(searchKey: searchKey);
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
                        .read<KanjiTabCubit>()
                        .loadKanjis(searchKey: value, page: 1);
                  },
                  onChanged: (value) {
                    searchKey = value;
                  },
                  hintText: 'Tìm kiếm kanji',
                ),
              ),
              Expanded(
                child: BlocConsumer<KanjiTabCubit, KanjiTabState>(
                  buildWhen: (previous, current) =>
                      current is KanjiTabLoaded || current is KanjiTabInitial,
                  builder: (context, state) {
                    if (state is KanjiTabInitial) {
                      return Center(
                        child: AppLoader(),
                      );
                    }
                    if (state is KanjiTabLoaded) {
                      if (state.kanjis.isEmpty) {
                        return Center(
                          child: Text(
                            'Không có kết quả nào',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.kanjis.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.kanjis.length) {
                            return KanjiItem(
                              index: index,
                              kanji: state.kanjis[index],
                            );
                          }
                          return SizedBox();
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        'Không có kanji nào',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  },
                  listener: (context, state) {
                    if (state is KanjiTabError) {
                      ToastHelper.showError(context, state.message);
                    }
                    if (state is KanjiTabSuccess) {
                      ToastHelper.showSuccess(context, state.message);
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
