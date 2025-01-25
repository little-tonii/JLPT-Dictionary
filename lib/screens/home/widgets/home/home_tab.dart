import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/helpers/toast_helper.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_state.dart';
import 'package:jlpt_dictionary/widgets/app_button.dart';
import 'package:jlpt_dictionary/widgets/app_dropdown_button.dart';
import 'package:jlpt_dictionary/widgets/app_input_text_field.dart';

class HomeTab extends StatelessWidget {
  final void Function(int) tabNavigator;

  const HomeTab({super.key, required this.tabNavigator});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<HomeTabCubit, HomeTabState>(
        listener: (context, state) {
          if (state is HomeTabError) {
            ToastHelper.showError(context, state.message);
          }
          if (state is HomeTabSucces) {
            ToastHelper.showSuccess(context, state.message);
          }
        },
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
                        BlocBuilder<HomeTabCubit, HomeTabState>(
                          buildWhen: (previous, current) =>
                              current is HomeTabCaroselLoaded,
                          builder: (context, state) {
                            if (state is HomeTabCaroselLoaded) {
                              return Image.asset(
                                'assets/carosels/${state.index}.jpg',
                                fit: BoxFit.cover,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: blurValue.clamp(0, 8),
                              sigmaY: blurValue.clamp(0, 8),
                            ),
                            child: Container(
                              color: AppColors.black.withValues(
                                alpha: opacityValue.clamp(0, 0.8),
                              ),
                            ),
                          ),
                        ),
                        if (currentHeight <= 120)
                          Center(
                            child: Text(
                              "万事随缘",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color:
                                        AppColors.white.withValues(alpha: 0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(
                              left: 12,
                              top: 12,
                            ),
                            width:
                                (MediaQuery.of(context).size.width - 12 * 3) /
                                    2,
                            height:
                                (MediaQuery.of(context).size.width - 12 * 3) /
                                    2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black.withValues(alpha: 0.1)
                                      : AppColors.white.withValues(alpha: 0.1),
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
                            margin: const EdgeInsets.only(
                              right: 12,
                              top: 12,
                            ),
                            width:
                                (MediaQuery.of(context).size.width - 12 * 3) /
                                    2,
                            height:
                                (MediaQuery.of(context).size.width - 12 * 3) /
                                    2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black.withValues(alpha: 0.1)
                                      : AppColors.white.withValues(alpha: 0.1),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.black.withValues(alpha: 0.1)
                                : AppColors.white.withValues(alpha: 0.1),
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
                              Spacer(),
                              GestureDetector(
                                onTap: () =>
                                    _handleOpenCreateVocabulary(context),
                                child: Icon(
                                  Ionicons.add_circle_outline,
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.black.withValues(alpha: 0.1)
                                : AppColors.white.withValues(alpha: 0.1),
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
                              Spacer(),
                              GestureDetector(
                                onTap: () => _handleOpenCreateKanji(context),
                                child: Icon(
                                  Ionicons.add_circle_outline,
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.black.withValues(alpha: 0.1)
                                : AppColors.white.withValues(alpha: 0.1),
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
                                "Ngữ pháp",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => _handleOpenCreateGrammar(context),
                                child: Icon(
                                  Ionicons.add_circle_outline,
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
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
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleOpenCreateVocabulary(BuildContext context) {
    final appContext = context;
    TextEditingController kanjiController = TextEditingController();
    TextEditingController normalController = TextEditingController();
    TextEditingController meaningController = TextEditingController();
    String currentLevel = '';
    showModalBottomSheet(
      context: appContext,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.watch<ThemeCubit>().state
                ? AppColors.white
                : AppColors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.watch<ThemeCubit>().state
                          ? AppColors.black.withValues(alpha: 0.2)
                          : AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Tạo từ vựng",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      color: context.watch<ThemeCubit>().state
                          ? AppColors.black.withValues(alpha: 0.4)
                          : AppColors.white.withValues(alpha: 0.4),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Dạng Kanji",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 4),
              AppInputTextField(
                controller: kanjiController,
                hintText: "Nhập dạng kanji",
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Dạng thông thường",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 4),
              AppInputTextField(
                controller: normalController,
                hintText: "Nhập dạng thông thường",
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Định nghĩa",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 4),
              AppInputTextField(
                controller: meaningController,
                hintText: "Nhập định nghĩa",
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "JLPT level",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 4),
              AppDropdownButton(
                onChanged: (value) {
                  currentLevel = value;
                },
                hint: "Chọn JLPT level",
                items: JlptLevel.values
                    .map(
                      (level) => DropdownMenuItem(
                        value: level.level
                            .split(".")
                            .last
                            .toString()
                            .toUpperCase(),
                        child: Text(
                          level.level.split(".").last.toString().toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: "Lưu lại",
                  onPressed: () {
                    if (currentLevel == '') {
                      return;
                    }
                    appContext.read<HomeTabCubit>().createVocabulary(
                          kanjiForm: kanjiController.text,
                          normalForm: normalController.text,
                          meaning: meaningController.text,
                          jlptLevel: currentLevel,
                        );
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleOpenCreateKanji(BuildContext context) {}

  void _handleOpenCreateGrammar(BuildContext context) {}
}
