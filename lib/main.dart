import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';

import 'package:troqueles_sw/config/user_type.dart';
import 'package:troqueles_sw/presentation/screens/login/loginScreen.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';
import 'package:troqueles_sw/presentation/screens/navigation/navigation_screen.dart';
import 'package:troqueles_sw/presentation/screens/accessibility/accessibility_screen.dart';
import 'package:troqueles_sw/presentation/providers/theme_provider.dart'; // << Importamos el nuevo provider

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeCustomProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return fluent.FluentApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Troqueles SW',
      theme: _buildFluentTheme(themeMode, fontSize),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  fluent.FluentThemeData _buildFluentTheme(
      ThemeModeCustom mode, double fontSize) {
    switch (mode) {
      case ThemeModeCustom.dark:
        return fluent.FluentThemeData(
          brightness: fluent.Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          typography: fluent.Typography.raw(
            body: TextStyle(fontSize: fontSize, color: Colors.white),
            title: TextStyle(
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0BAFFE)),
          ),
          cardColor: Colors.grey[900],
          accentColor: fluent.Colors.blue,
        );
      case ThemeModeCustom.highContrast:
        return fluent.FluentThemeData(
          brightness: fluent.Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          typography: fluent.Typography.raw(
            body: TextStyle(
                fontSize: fontSize,
                color: Colors.yellow,
                fontWeight: FontWeight.bold),
            title: TextStyle(
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          ),
          cardColor: Colors.black,
          accentColor: fluent.Colors.yellow,
        );
      case ThemeModeCustom.light:
      default:
        return fluent.FluentThemeData(
          brightness: fluent.Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          typography: fluent.Typography.raw(
            body: TextStyle(fontSize: fontSize, color: Colors.black),
            title: TextStyle(
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00205B)),
          ),
          cardColor: Colors.white,
          accentColor: fluent.Colors.blue,
        );
    }
  }
}

// Define el router de la aplicación
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/navigation/jefe',
      builder: (context, state) =>
          const NavigationScreen(userType: UserType.jefe),
    ),
    GoRoute(
      path: '/navigation/operario',
      builder: (context, state) =>
          const NavigationScreen(userType: UserType.operario),
    ),
    GoRoute(
      path: '/accessibility',
      builder: (context, state) => const AccessibilityScreen(),
    ),
  ],
);
