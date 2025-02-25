import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/presentation/screens/login/loginScreen.dart';
// Importa LoginScreen
import 'package:troqueles_sw/presentation/screens/navigation/navigation_screen.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';

enum UserType { operario, jefe }

final appRouter = GoRouter(
  initialLocation: '/', // Ruta inicial es LoginScreen
  routes: [
    GoRoute(
      path: '/',
      name: 'login', // Nombre de la ruta de inicio de sesión
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/navigation/:userType', // Ruta para NavigationScreen con parámetro
      name: NavigationScreen.name,
      builder: (context, state) {
        // Obtener el parámetro userType de la ruta
        final userType = state.pathParameters['userType'] == 'jefe'
            ? UserType.jefe
            : UserType.operario;
        return NavigationScreen(userType: userType);
      },
      routes: [
        GoRoute(
          path: 'home', // Ruta anidada para HomeScreen
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
  ],
);