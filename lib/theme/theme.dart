import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true, // ✅ Enable Material 3
  colorSchemeSeed: MyColors.lime, // For dynamic theming
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true, // ✅ Enable Material 3
  colorSchemeSeed: MyColors.lime, // For dynamic theming
  brightness: Brightness.dark,
);
