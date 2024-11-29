import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/config/router/app_router.dart';
import 'package:troqueles_sw/config/theme/app_theme.dart';


void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  static const name = 'Home-Screen';
  
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // Instancia del tema personalizado
    final AppTheme appTheme = AppTheme();

    return FluentApp.router(
      // Configuración del enrutador
      routerConfig: appRouter,

      // Configuración del tema
      themeMode: ThemeMode.system, // Cambia automáticamente entre claro y oscuro según el sistema
      theme: appTheme.getLightFluentTheme(),
      darkTheme: appTheme.getDarkFluentTheme(),

      // Configuración adicional
      debugShowCheckedModeBanner: false,
      title: 'Troqueles Smurfit WestRock',
    );
  }
}