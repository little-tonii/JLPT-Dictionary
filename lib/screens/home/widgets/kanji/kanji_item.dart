import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/models/kanji_model.dart';

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
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: appContext,
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
              SingleChildScrollView(
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
                  ],
                ),
              ),
            ],
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
