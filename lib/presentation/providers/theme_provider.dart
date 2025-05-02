import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeCustom { light, dark, highContrast }

final themeModeCustomProvider =
    StateNotifierProvider<ThemeNotifier, ThemeModeCustom>((ref) {
  return ThemeNotifier();
});

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeModeCustom> {
  ThemeNotifier() : super(ThemeModeCustom.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString('theme_mode') ?? 'light';
    state = ThemeModeCustom.values.firstWhere((e) => e.name == mode);
  }

  Future<void> setTheme(ThemeModeCustom mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.name);
  }
}

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(16.0) {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final size = prefs.getDouble('font_size') ?? 16.0;
    state = size;
  }

  Future<void> setFontSize(double size) async {
    state = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', size);
  }
}
