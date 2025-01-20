import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/models/vocabulary_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          Column(
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
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: _speak,
              child: Icon(
                Icons.volume_up_rounded,
                color: context.watch<ThemeCubit>().state
                    ? AppColors.black.withValues(alpha: 0.4)
                    : AppColors.white.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
