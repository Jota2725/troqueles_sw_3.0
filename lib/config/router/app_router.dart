import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/presentation/screens/login/loginScreen.dart';
import 'package:troqueles_sw/presentation/screens/navigation/navigation_screen.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';
import 'package:troqueles_sw/presentation/screens/accessibility/accessibility_screen.dart';
import 'package:troqueles_sw/config/user_type.dart';

final appRouter = GoRouter(
  initialLocation: '/', // Ruta inicial es LoginScreen
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/navigation/:userType',
      name: NavigationScreen.name,
      builder: (context, state) {
        final userType = state.pathParameters['userType'] == 'jefe'
            ? UserType.jefe
            : UserType.operario;
        return NavigationScreen(userType: userType);
      },
      routes: [
        GoRoute(
          path: 'home',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/accessibility',
      name: 'accessibility',
      builder: (context, state) => const AccessibilityScreen(),
    ),
  ],
);
