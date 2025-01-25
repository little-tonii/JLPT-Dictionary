import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/enums/jlpt_level.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/models/vocabulary_model.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_cubit.dart';
import 'package:jlpt_dictionary/widgets/app_button.dart';
import 'package:jlpt_dictionary/widgets/app_dropdown_button.dart';
import 'package:jlpt_dictionary/widgets/app_input_text_field.dart';

class VocabularyItem extends StatelessWidget {
  final VocabularyModel vocabulary;
  final int index;
  final FlutterTts _flutterTts = FlutterTts();

  VocabularyItem({
    super.key,
    required this.vocabulary,
    required this.index,
  });

  Future<void> _speak() async {
    await _flutterTts.setLanguage('ja-JP');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1);
    await _flutterTts.speak(vocabulary.kanjiForm == ''
        ? vocabulary.normalForm
        : vocabulary.kanjiForm);
  }

  void _handleOpenEditVocabulary(BuildContext context) {
    final appContext = context;
    TextEditingController kanjiController =
        TextEditingController(text: vocabulary.kanjiForm);
    TextEditingController normalController =
        TextEditingController(text: vocabulary.normalForm);
    TextEditingController meaningController =
        TextEditingController(text: vocabulary.meaning);
    String currentLevel = vocabulary.jlptLevel.level.toString().toUpperCase();
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
                    "Chỉnh sửa từ vựng",
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
                displayText: currentLevel,
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
                  text: "Cập nhật",
                  onPressed: () {
                    appContext.read<VocabularyTabCubit>().updateVocabulary(
                          kanjiForm: kanjiController.text,
                          normalForm: normalController.text,
                          meaning: meaningController.text,
                          id: vocabulary.id!,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOpenEditVocabulary(context),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vocabulary.kanjiForm,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      vocabulary.normalForm,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      vocabulary.meaning,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _speak,
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: context.watch<ThemeCubit>().state
                          ? AppColors.black.withValues(alpha: 0.4)
                          : AppColors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
