import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class AppTheme {
  // Paleta de acento personalizada para Fluent UI
  AccentColor get customAccentColor => AccentColor.swatch(const <String, Color>{
        'normal': Color(0xFF0BAFFE), // Color principal
        'lighter': Color(0xFF5FCFFF), // Más claro
        'light': Color(0xFF3EC0FF), // Claro
        'dark': Color(0xFF087AB0), // Oscuro
        'darker': Color(0xFF065780), // Más oscuro
      });

// Configuración del tema  de Fluent UI claro
  FluentThemeData getLightFluentTheme() => FluentThemeData(
        brightness: Brightness.light,
        accentColor: customAccentColor,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        iconTheme: const IconThemeData(color: Color(0xFF00205B)),
        dialogTheme: const ContentDialogThemeData(
          barrierColor: Color.fromARGB(255, 255, 255, 255),
        ),
        // Tema del navegation Theme
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: const Color(0xFFF5F5F5),
          selectedIconColor: WidgetStateProperty.all(customAccentColor),
          selectedTextStyle:
              WidgetStateProperty.all(TextStyle(color: customAccentColor)),
          unselectedIconColor: WidgetStateProperty.all(const Color(0xFF00205B)),
          unselectedTextStyle: WidgetStateProperty.all(
              const TextStyle(color: Color(0xFF00205B))),
        ),
      );

// Configuración del tema de Fluent UI oscuro
  FluentThemeData getDarkFluentTheme() => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: customAccentColor,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: const IconThemeData(color: Color(0xFF0BAFFE)),
        dialogTheme: const ContentDialogThemeData(
          barrierColor: Color.fromARGB(255, 0, 0, 0),
        ),
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          selectedIconColor: WidgetStateProperty.all(customAccentColor),
          selectedTextStyle:
              WidgetStateProperty.all(TextStyle(color: customAccentColor)),
          unselectedIconColor: WidgetStateProperty.all(const Color(0xFFF5F5F5)),
          unselectedTextStyle: WidgetStateProperty.all(
              const TextStyle(color: Color(0xFFF5F5F5))),
        ),
      );

//Configuracion del tema de Material 
  material.ThemeData getMaterialTheme(bool isDarkMode) => material.ThemeData(
        brightness:
            isDarkMode ? material.Brightness.dark : material.Brightness.light,
        dialogTheme: const material.DialogTheme(
          backgroundColor: material.Colors.white, // Fondo opaco
          elevation: 10, // Sin transparencia
        ),
        cardColor: isDarkMode
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color(0xFFFFFFFF),
        scaffoldBackgroundColor: isDarkMode
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color(0xFFF5F5F5),
        colorScheme: material.ColorScheme.fromSwatch(
          primarySwatch: material.Colors.blue,
          brightness:
              isDarkMode ? material.Brightness.dark : material.Brightness.light,
        ),
      );
}
