import 'package:fluent_ui/fluent_ui.dart';

class AppTheme {
  // Crear una paleta de acento personalizada para Fluent UI
  AccentColor get customAccentColor => AccentColor.swatch(const <String, Color>{
        'normal': Color(0xFF0BAFFE), // Color principal
        'lighter': Color(0xFF5FCFFF), // Más claro
        'light': Color(0xFF3EC0FF),   // Claro
        'dark': Color(0xFF087AB0),    // Oscuro
        'darker': Color(0xFF065780),  // Más oscuro
      });

  FluentThemeData getLightTheme() => FluentThemeData(
        brightness: Brightness.light,
        accentColor: customAccentColor,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        iconTheme: const IconThemeData(color: Color(0xFF00205B)),
        dialogTheme:  const ContentDialogThemeData(
          barrierColor:  Color(0xFFFFFFFF), // Color de fondo sin transparencia
        ), 
        
         navigationPaneTheme: NavigationPaneThemeData(
          
          backgroundColor: const Color(0xFFF5F5F5),
         selectedIconColor: WidgetStateProperty.all(customAccentColor),
          selectedTextStyle:   WidgetStateProperty.all(TextStyle(color: customAccentColor)),
          unselectedIconColor: WidgetStateProperty.all(const Color(0xFF00205B)),
          unselectedTextStyle: WidgetStateProperty.all(const TextStyle(color: Color(0xFF00205B)) ),
        ),
        
      );
      

  FluentThemeData getDarkTheme() => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: customAccentColor,
        scaffoldBackgroundColor: const Color(0xFF141414),
        iconTheme: const IconThemeData(color: Color(0xFF0BAFFE)),
         navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: const Color(0xFF141414),
         selectedIconColor: WidgetStateProperty.all(customAccentColor),
          selectedTextStyle:   WidgetStateProperty.all(TextStyle(color: customAccentColor)),
          unselectedIconColor: WidgetStateProperty.all(const Color(0xFFF5F5F5)),
          unselectedTextStyle: WidgetStateProperty.all(const TextStyle(color: Color(0xFFF5F5F5)) ),
        ),
      );
}
