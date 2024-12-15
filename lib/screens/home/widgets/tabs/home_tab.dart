import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_state.dart';

class HomeTab extends StatelessWidget {
  final void Function(int) tabNavigator;

  const HomeTab({super.key, required this.tabNavigator});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => tabNavigator(1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black.withOpacity(0.1)
                            : AppColors.white.withOpacity(0.1), // Màu bóng mờ
                        blurRadius: 8, // Độ mờ của bóng
                        offset: const Offset(4, 4), // Độ dịch chuyển của bóng
                      ),
                    ],
                    color: context.watch<ThemeCubit>().state
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  margin: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Từ vựng",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ...JlptLevel.values.map(
                        (level) => Row(
                          children: [
                            Text(
                              level.name.toUpperCase(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<HomeTabCubit, HomeTabState>(
                              buildWhen: (previous, current) =>
                                  current is HomeTabVocabularyLoaded,
                              builder: (context, state) {
                                if (state is HomeTabVocabularyLoaded) {
                                  return Text(
                                    state.vocabularyCount[level].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  );
                                }
                                return Text(
                                  "0",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => tabNavigator(2),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black.withOpacity(0.1)
                            : AppColors.white.withOpacity(0.1), // Màu bóng mờ
                        blurRadius: 8, // Độ mờ của bóng
                        offset: const Offset(4, 4), // Độ dịch chuyển của bóng
                      ),
                    ],
                    color: context.watch<ThemeCubit>().state
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  margin: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Kanji",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ...JlptLevel.values.map(
                        (level) => Row(
                          children: [
                            Text(
                              level.name.toUpperCase(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<HomeTabCubit, HomeTabState>(
                              buildWhen: (previous, current) =>
                                  current is HomeTabKanjiLoaded,
                              builder: (context, state) {
                                if (state is HomeTabKanjiLoaded) {
                                  return Text(
                                    state.kanjiCount[level].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  );
                                }
                                return Text(
                                  "0",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => tabNavigator(3),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black.withOpacity(0.1)
                            : AppColors.white.withOpacity(0.1), // Màu bóng mờ
                        blurRadius: 8, // Độ mờ của bóng
                        offset: const Offset(4, 4), // Độ dịch chuyển của bóng
                      ),
                    ],
                    color: context.watch<ThemeCubit>().state
                        ? AppColors.white
                        : AppColors.black,
                  ),
                  margin: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Ngữ pháp",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ...JlptLevel.values.map(
                        (level) => Row(
                          children: [
                            Text(
                              level.name.toUpperCase(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<HomeTabCubit, HomeTabState>(
                              buildWhen: (previous, current) =>
                                  current is HomeTabGrammarLoaded,
                              builder: (context, state) {
                                if (state is HomeTabGrammarLoaded) {
                                  return Text(
                                    state.grammarCount[level].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  );
                                }
                                return Text(
                                  "0",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
