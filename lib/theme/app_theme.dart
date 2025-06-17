import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/colors.dart';

class AppTheme {
  static ThemeData light(Color primary) => ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.light(primary: primary, secondary: MyColors.black),
    // appBarTheme: AppBarTheme(backgroundColor: primary),
  );

  static ThemeData dark(Color primary) => ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.dark(primary: primary, secondary: MyColors.white),
    // appBarTheme: AppBarTheme(backgroundColor: primary),
  );
}
