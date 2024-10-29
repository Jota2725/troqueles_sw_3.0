import 'package:fluent_ui/fluent_ui.dart';
import 'package:troqueles_sw/config/router/app_router.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const name = 'Home-Screen';
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  FluentApp.router(
      routerConfig: appRouter ,
      debugShowCheckedModeBanner: false,
      title: 'Troqueles Smurfit WestRock',
      
    );
  }
}