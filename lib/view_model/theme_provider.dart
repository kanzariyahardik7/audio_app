import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = 'theme_mode';
  static const _primaryColorKey = 'primary_color';

  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = MyColors.primaryColor;

  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;

  ThemeProvider() {
    _loadThemeSettings();
  }

  void _loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _getThemeModeFromString(
      prefs.getString(_themeKey) ?? 'system',
    );

    final savedColor = prefs.getInt(_primaryColorKey);
    if (savedColor != null) {
      _primaryColor = Color(savedColor);
    }

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryColorKey, color.value);
  }

  ThemeMode _getThemeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
