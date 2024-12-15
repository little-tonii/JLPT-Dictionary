import 'dart:math';
import 'dart:ui';

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
    final indexImage = Random().nextInt(3) + 1;
    final currentDate = DateTime.now();
    final currentDay =
        currentDate.day < 10 ? "0${currentDate.day}" : currentDate.day;
    final currentMonth =
        currentDate.month < 10 ? "0${currentDate.month}" : currentDate.month;
    final currentYear = "${currentDate.year}";
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 60,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final currentHeight = constraints.maxHeight;
                  final blurValue = (200 - currentHeight) / 25;
                  final opacityValue = (200 - currentHeight) / 200;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/carosels/$indexImage.jpg',
                        fit: BoxFit.cover,
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: blurValue.clamp(0, 8),
                            sigmaY: blurValue.clamp(0, 8),
                          ),
                          child: Container(
                            color: AppColors.black.withOpacity(
                              opacityValue.clamp(0, 0.8),
                            ),
                          ),
                        ),
                      ),
                      if (currentHeight <= 120)
                        Center(
                          child: Text(
                            "$currentDay/$currentMonth/$currentYear",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColors.white.withOpacity(0.6)),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
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
                                : AppColors.white.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
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
                                : AppColors.white.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
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
                                : AppColors.white.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 12),
                          width:
                              (MediaQuery.of(context).size.width - 12 * 3) / 2,
                          height:
                              (MediaQuery.of(context).size.width - 12 * 3) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: context.watch<ThemeCubit>().state
                                    ? AppColors.black.withOpacity(0.1)
                                    : AppColors.white.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(4, 4),
                              ),
                            ],
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.white
                                : AppColors.black,
                          ),
                          child: Text(
                            "Luyện tập từ vựng",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 12),
                          width:
                              (MediaQuery.of(context).size.width - 12 * 3) / 2,
                          height:
                              (MediaQuery.of(context).size.width - 12 * 3) / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: context.watch<ThemeCubit>().state
                                    ? AppColors.black.withOpacity(0.1)
                                    : AppColors.white.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(4, 4),
                              ),
                            ],
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.white
                                : AppColors.black,
                          ),
                          child: Text(
                            "Luyện tập kanji",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
