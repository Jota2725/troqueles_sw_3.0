
import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';
import 'package:troqueles_sw/presentation/screens/navigation_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: NavigationScreen.name,
    builder: (context, state) => const NavigationScreen(),
    routes: [
 
  GoRoute(
      path: '/HomeScreen',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()
      ),


    ]
  ),
 
]);