import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData basicTheme() {
  TextTheme basicTextTheme() {
    return ThemeData.light()
        .textTheme
        .copyWith(
          titleLarge:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          titleMedium:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          titleSmall:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          bodyLarge: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          bodyMedium:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          bodySmall: const TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
        )
        .apply(
            bodyColor: AppColors.textColor, displayColor: AppColors.textColor);
  }

  return ThemeData.light().copyWith(
      textTheme: basicTextTheme(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          tertiary: AppColors.tertiaryColor,
          outline: AppColors.borderColor,
          onError: AppColors.errorColor),
      scaffoldBackgroundColor:    AppColors.extraWhiteLight,
      hintColor: AppColors.hintTextColor,
      errorColor: AppColors.errorColor,
      backgroundColor: AppColors.backGroundColor);
}
