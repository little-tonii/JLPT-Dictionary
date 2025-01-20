import 'package:flutter/material.dart';

class KanjiTab extends StatelessWidget {
  const KanjiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // Container(
              //   padding: EdgeInsets.all(8),
              //   width: double.infinity,
              //   child: SearchTextField(
              //     onSubmit: (value) {},
              //     hintText: 'Tìm kiếm Hán tự',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
