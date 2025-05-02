import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:troqueles_sw/presentation/providers/theme_provider.dart';

class AppTheme {
  // Paleta de acento
  AccentColor get customAccentColor => AccentColor.swatch(const <String, Color>{
        'normal': Color(0xFF0BAFFE),
        'lighter': Color(0xFF5FCFFF),
        'light': Color(0xFF3EC0FF),
        'dark': Color(0xFF087AB0),
        'darker': Color(0xFF065780),
      });

  // === Fluent UI Themes ===

  FluentThemeData getFluentTheme(ThemeModeCustom mode, double fontScale) {
    switch (mode) {
      case ThemeModeCustom.dark:
        return _darkTheme(fontScale);
      case ThemeModeCustom.highContrast:
        return _highContrastTheme(fontScale);
      default:
        return _lightTheme(fontScale);
    }
  }

  FluentThemeData _lightTheme(double scale) => FluentThemeData(
        brightness: Brightness.light,
        accentColor: customAccentColor,
        iconTheme: const IconThemeData(color: Color(0xFF00205B)),
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: const Color(0xFFF5F5F5),
          selectedIconColor: WidgetStateProperty.all(customAccentColor),
          selectedTextStyle: WidgetStateProperty.all(
            TextStyle(color: customAccentColor, fontSize: 16 * scale),
          ),
          unselectedIconColor: WidgetStateProperty.all(const Color(0xFF00205B)),
          unselectedTextStyle: WidgetStateProperty.all(
            TextStyle(color: const Color(0xFF00205B), fontSize: 14 * scale),
          ),
        ),
      );

  FluentThemeData _darkTheme(double scale) => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: customAccentColor,
        iconTheme: const IconThemeData(color: Color(0xFF0BAFFE)),
        navigationPaneTheme: NavigationPaneThemeData(
          selectedTextStyle: WidgetStateProperty.all(
            TextStyle(color: customAccentColor, fontSize: 16 * scale),
          ),
          unselectedTextStyle: WidgetStateProperty.all(
            TextStyle(color: const Color(0xFFF5F5F5), fontSize: 14 * scale),
          ),
        ),
      );

  FluentThemeData _highContrastTheme(double scale) => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: customAccentColor,
        iconTheme: const IconThemeData(color: Color(0xFFFFFF00)),
        navigationPaneTheme: NavigationPaneThemeData(
          selectedTextStyle: WidgetStateProperty.all(
            TextStyle(
              color: const Color(0xFFFFFF00), // Amarillo fluorescente
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          unselectedTextStyle: WidgetStateProperty.all(
            TextStyle(
              color: const Color(0xFFFFFF00),
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  // === Material Theme ===

  material.ThemeData getMaterialTheme(ThemeModeCustom mode, double fontScale) {
    final isDark = mode != ThemeModeCustom.light;
    final baseColor =
        mode == ThemeModeCustom.highContrast ? material.Colors.yellow : null;
    return material.ThemeData(
      brightness: isDark ? material.Brightness.dark : material.Brightness.light,
      textTheme: material.Typography().black.apply(
            fontSizeFactor: fontScale,
            bodyColor: baseColor,
            displayColor: baseColor,
          ),
    );
  }
}
