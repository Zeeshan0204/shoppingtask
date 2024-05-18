import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
      // primaryColor: AppColors.black,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      }),
      scaffoldBackgroundColor: AppColors.white,

      primaryColorLight: AppColors.purplebottomnav,
      dialogBackgroundColor: AppColors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.purplebottomnav),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.purpleAccent, // but now it should be declared like this
      ).copyWith(background: AppColors.black),
      // errorColor: AppColors.greyAccent,
    );
  }
}
