import 'package:flutter/material.dart';

class VocabularyTab extends StatelessWidget {
  const VocabularyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "Vocabulary Tab",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
