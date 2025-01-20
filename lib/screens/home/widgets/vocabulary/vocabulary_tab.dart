import 'package:flutter/material.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/widgets/search_text_field.dart';

class VocabularyTab extends StatelessWidget {
  const VocabularyTab({super.key});

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
                child: SearchTextField(
                  onSubmit: (value) {},
                  hintText: 'Tìm kiếm từ vựng',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
