import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/kanji_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/widgets/kanji/edit_kanji.dart';

class KanjiItem extends StatelessWidget {
  final KanjiModel kanji;
  final int index;
  const KanjiItem({
    super.key,
    required this.kanji,
    required this.index,
  });

  void _handleOpenEditKanji(BuildContext context) {
    final appContext = context;
    appContext.read<KanjiTabCubit>().loadYomis(kanjiId: kanji.id!);
    final kanjiTabCubit = appContext.read<KanjiTabCubit>();
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: appContext,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: context.watch<ThemeCubit>().state
                ? AppColors.white
                : AppColors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: EditKanji(
            kanji: kanji,
            kanjiTabCubit: kanjiTabCubit,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOpenEditKanji(context),
      child: Container(
        margin: EdgeInsets.only(
          top: index == 0 ? 8 : 0,
          bottom: 8,
          left: 8,
          right: 8,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.watch<ThemeCubit>().state
              ? AppColors.white
              : AppColors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.watch<ThemeCubit>().state
                ? AppColors.black.withValues(alpha: 0.2)
                : AppColors.white.withValues(alpha: 0.2),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: FittedBox(
                  child: Text(
                    kanji.kanji,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          kanji.viet,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          kanji.jlptLevel.level.split(".").last,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "Số nét: ${kanji.numberOfWritingStrokes}",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
