import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'Home-Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyhomeWidgetState();
}

class _MyhomeWidgetState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/Sustainability.png'),
      fit: BoxFit.cover,
    );
  }
}
