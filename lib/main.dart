import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/config/user_type.dart';
import 'package:troqueles_sw/presentation/screens/accessibility/accessibility_provider.dart';
import 'package:troqueles_sw/presentation/screens/login/loginScreen.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';
import 'package:troqueles_sw/presentation/screens/navigation/navigation_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessibility = ref.watch(accessibilityProvider);

    return fluent.FluentApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Troqueles SW',
      theme: fluent.FluentThemeData(
        brightness: accessibility.isHighContrast
            ? fluent.Brightness.dark
            : fluent.Brightness.light,
        typography: fluent.Typography.raw(
          body: TextStyle(fontSize: accessibility.fontSize),
        ),
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

// Define el router de la aplicación de forma global
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
      builder: (context, state) => NavigationScreen(userType: UserType.jefe),
    ),
    GoRoute(
      path: '/navigation/operario',
      builder: (context, state) =>
          NavigationScreen(userType: UserType.operario),
    ),
  ],
);
