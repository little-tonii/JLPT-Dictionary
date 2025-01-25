import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jlpt_dictionary/dependencies/dependencies.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/home_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/cubits/vocabulary_tab_cubit.dart';
import 'package:jlpt_dictionary/screens/home/widgets/grammar/grammar_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/home/home_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/kanji/kanji_tab.dart';
import 'package:jlpt_dictionary/screens/home/widgets/vocabulary/vocabulary_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final HomeTabCubit _homeTabCubit =
      DependenciesContainer.getIt.get<HomeTabCubit>();

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
        resizeToAvoidBottomInset: false,
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
              ? Colors.black.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.4),
          splashRadius: 0,
          splashColor: Colors.transparent,
          splashSpeedInMilliseconds: 0,
          scaleFactor: 1,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            BlocProvider<HomeTabCubit>(
              create: (context) => _homeTabCubit
                ..loadCarosel()
                ..loadVocabularies()
                ..loadKanjis()
                ..loadGrammars(),
              child: HomeTab(tabNavigator: _handleItemTapped),
            ),
            BlocProvider<VocabularyTabCubit>(
              create: (context) =>
                  DependenciesContainer.getIt.get<VocabularyTabCubit>()
                    ..loadVocabularies(page: 1),
              child: VocabularyTab(
                homeTabCubit: _homeTabCubit,
              ),
            ),
            const KanjiTab(),
            const GrammarTab(),
          ],
        ),
      ),
    );
  }
}
