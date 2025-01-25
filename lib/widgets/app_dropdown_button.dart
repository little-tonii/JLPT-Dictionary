import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:jlpt_dictionary/global_cubits/theme_cubit/theme_cubit.dart';

class AppDropdownButton extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final String displayText;

  const AppDropdownButton({
    super.key,
    required this.items,
    required this.displayText,
  });

  @override
  State<AppDropdownButton> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  late String currentSelected;

  @override
  void initState() {
    currentSelected = widget.displayText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          "Chọn JLPT level",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        items: widget.items,
        value: currentSelected,
        onChanged: (value) {
          setState(() {
            currentSelected = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.black.withValues(alpha: 0.4)
                  : AppColors.white.withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(8),
            color: context.watch<ThemeCubit>().state
                ? AppColors.white
                : AppColors.black,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          offset: Offset(0, -4),
          decoration: BoxDecoration(
            color: context.watch<ThemeCubit>().state
                ? AppColors.white
                : AppColors.black,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: context.watch<ThemeCubit>().state
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
