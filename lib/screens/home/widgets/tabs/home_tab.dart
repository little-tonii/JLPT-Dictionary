import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "Home Tab",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
