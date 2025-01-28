import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/enums/yomi_type.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_state.dart';
import 'package:jlpt_dictionary/widgets/app_button.dart';
import 'package:jlpt_dictionary/widgets/app_input_text_field.dart';

class EditKanji extends StatelessWidget {
  final KanjiTabCubit kanjiTabCubit;
  final KanjiModel kanji;

  const EditKanji({
    super.key,
    required this.kanji,
    required this.kanjiTabCubit,
  });

  void _handleCreateNewYomi(BuildContext context, YomiType yomiType) {
    TextEditingController textEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.red,
          insetPadding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.white
                  : AppColors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black.withValues(alpha: 0.4)
                            : AppColors.white.withValues(alpha: 0.4),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Thêm mới âm ${yomiType == YomiType.kunyomi ? "kun" : "on"} cho kanji ${kanji.kanji}",
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppInputTextField(
                        hintText: "Nhập âm Kun",
                        controller: textEditingController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Xác nhận",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _loadYomi(BuildContext context, YomiType yomiType) {
    return BlocBuilder<KanjiTabCubit, KanjiTabState>(
      bloc: kanjiTabCubit,
      buildWhen: (previous, current) => current is KanjiTabYomiLoaded,
      builder: (context, state) {
        if (state is KanjiTabYomiLoaded) {
          final yomis = state.yomis.where(
            (element) => element.yomiType == yomiType,
          );
          return SizedBox(
            child: Column(
              children: [
                ...yomis.map(
                  (yomi) {
                    kanjiTabCubit.loadSamples(
                      kanjiId: kanji.id!,
                      yomiId: yomi.id!,
                    );
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.watch<ThemeCubit>().state
                                ? AppColors.black.withValues(alpha: 0.08)
                                : AppColors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                yomi.pronounce,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: context.watch<ThemeCubit>().state
                                      ? AppColors.black.withValues(alpha: 0.4)
                                      : AppColors.white.withValues(alpha: 0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<KanjiTabCubit, KanjiTabState>(
                          bloc: kanjiTabCubit,
                          buildWhen: (previous, current) =>
                              current is KanjiTabKanjiSampleLoaded &&
                              current.yomiId == yomi.id,
                          builder: (context, state) {
                            if (state is KanjiTabKanjiSampleLoaded) {
                              return Column(
                                children: [
                                  if (state.samples.isNotEmpty)
                                    SizedBox(height: 8),
                                  ...state.samples.asMap().entries.map(
                                    (entry) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          bottom: entry.key ==
                                                  state.samples.length - 1
                                              ? 0
                                              : 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                entry.value.kanjiForm,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                entry.value.normalForm,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                entry.value.meaning,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              "Chỉnh sửa kanji",
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(
                    'assets/svgs/${context.watch<ThemeCubit>().state ? 'light' : 'dark'}/${kanji.kanji}.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Âm Hán Việt: ",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      kanji.viet,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Số nét viết: ",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      kanji.numberOfWritingStrokes.toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "JLPT: ",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      kanji.jlptLevel.level.split(".").last,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Âm Kun",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _handleCreateNewYomi(
                        context,
                        YomiType.kunyomi,
                      ),
                      child: Icon(
                        Ionicons.add_circle_outline,
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                _loadYomi(context, YomiType.kunyomi),
                Row(
                  children: [
                    Text(
                      "Âm On",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _handleCreateNewYomi(
                        context,
                        YomiType.onyomi,
                      ),
                      child: Icon(
                        Ionicons.add_circle_outline,
                        color: context.watch<ThemeCubit>().state
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                _loadYomi(context, YomiType.onyomi),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
