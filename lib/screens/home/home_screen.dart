import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/home/widgets/tabs/grammar_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/tabs/home_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/tabs/kanji_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/tabs/vocabulary_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _handleItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleChangeTheme() {
    context.read<ThemeCubit>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _handleChangeTheme,
          child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              if (state) {
                return const Icon(Ionicons.moon_outline);
              } else {
                return const Icon(Ionicons.sunny_outline);
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          icons: const [
            Ionicons.home_outline,
            Ionicons.receipt_outline,
            Ionicons.skull_outline,
            Ionicons.library_outline,
          ],
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 16,
          rightCornerRadius: 16,
          activeIndex: _currentIndex,
          onTap: _handleItemTapped,
          gapLocation: GapLocation.center,
          activeColor:
              context.watch<ThemeCubit>().state ? Colors.black : Colors.white,
          inactiveColor: context.watch<ThemeCubit>().state
              ? Colors.black.withOpacity(0.4)
              : Colors.white.withOpacity(0.4),
          splashRadius: 0,
          splashColor: Colors.transparent,
          splashSpeedInMilliseconds: 0,
          scaleFactor: 1,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeTab(),
            VocabularyTab(),
            KanjiTab(),
            GrammarTab(),
          ],
        ),
      ),
    );
  }
}
