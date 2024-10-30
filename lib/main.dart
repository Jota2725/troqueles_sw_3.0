import 'package:fluent_ui/fluent_ui.dart';
import 'package:troqueles_sw/config/router/app_router.dart';
import 'package:troqueles_sw/config/theme/app_theme.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const name = 'Home-Screen';
  
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = AppTheme();
    return  FluentApp.router(
      routerConfig: appRouter ,
      themeMode: ThemeMode.system,
      theme: appTheme.getLightTheme(),
      darkTheme: appTheme.getDarkTheme(),

      debugShowCheckedModeBanner: false,
      title: 'Troqueles Smurfit WestRock',
      
    );
  }
}