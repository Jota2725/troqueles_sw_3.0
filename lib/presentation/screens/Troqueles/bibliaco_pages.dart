import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';

import '../../../domain/entities/troqueles.dart';
import '../../../infrastructure/datasource/troquel_datasource.dart';

class BibliacoPages extends StatefulWidget {
  static const name = 'bibliaco_pages';
  const BibliacoPages({super.key});

  @override
  _BibliacoPagesState createState() => _BibliacoPagesState();
}

class _BibliacoPagesState extends State<BibliacoPages> {
  final String hojaDeseada = 'NombreDeTuHoja';
  List<Troquel> troqueles = [];

  // Método para importar datos desde el archivo Excel
  Future<void> _importarDesdeExcel() async {
    final datasource = TroquelDatasourceImpl();
    List<Troquel> datosImportados =
        await datasource.seleccionarArchivoExcel('WA');

    setState(() {
      troqueles = datosImportados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TROQUELADORA WARD'),
        centerTitle: true,
       
      ),
      body: TroquelTable(
        troqueles: troqueles,
        onImportPressed: _importarDesdeExcel,
      ),
    );
  }
}
