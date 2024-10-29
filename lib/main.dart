import 'package:flutter/material.dart';
import 'package:troqueles_sw/config/router/app_router.dart';
import 'package:troqueles_sw/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const name = 'Home-Screen';
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: appRouter ,
      debugShowCheckedModeBanner: false,
      title: 'Troqueles Smurfit WestRock',
      theme:  AppTheme().getTheme(), 
    );
  }
}