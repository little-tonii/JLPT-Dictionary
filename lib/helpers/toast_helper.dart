import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jlpt_dictionary/constants/colors.dart';
import 'package:toastification/toastification.dart';

abstract class ToastHelper {
  static void showError(BuildContext context, String message) {
    toastification.show(
      context: context,
      style: ToastificationStyle.fillColored,
      type: ToastificationType.error,
      title: Text(
        message,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      foregroundColor: AppColors.black,
      primaryColor: AppColors.white,
      icon: Icon(
        Ionicons.close_circle_outline,
        color: AppColors.red,
      ),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
      ),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      borderRadius: BorderRadius.circular(8),
      closeButtonShowType: CloseButtonShowType.none,
      closeOnClick: true,
    );
  }
}
