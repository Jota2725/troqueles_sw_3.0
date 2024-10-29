import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_menu_troqueles.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('TROQUELES SMURFIT WESTROCK',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(23, 13, 171, 1),
          centerTitle: true),
      body: Row(
        children: [
          MenuTroqueles(size: size),
          SizedBox(
            width: size.width * 0.8,
            // Ancho completo de la pantalla
            child: const TroquelTable(),
          ),
        ],
      ),
    );
  }
}