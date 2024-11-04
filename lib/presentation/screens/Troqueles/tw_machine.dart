import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';

import '../../../domain/entities/troquel.dart';
import '../../../infrastructure/datasource/troquel_datasource.dart';

class TWPage extends StatefulWidget {
  static const name = 'bibliaco_pages';
  const TWPage({super.key});

  @override
  _BibliacoPagesState createState() => _BibliacoPagesState();
}

class _BibliacoPagesState extends State<TWPage> {
  final String hojaDeseada = 'TW'; // Nombre de la hoja deseada en este caso
  List<Troquel> troqueles = [];

  @override
  void initState() {
    super.initState();
    _cargarDatosDesdeBaseDeDatosPorMaquina('TW'); // Carga los datos al iniciar la pantalla
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<void> _cargarDatosDesdeBaseDeDatos() async {
    final datasource = TroquelDatasourceImpl();
    List<Troquel> datosDesdeBD = await datasource.getAllTroqueles();

    setState(() {
      troqueles = datosDesdeBD;
    });
  }


  void _cargarDatosDesdeBaseDeDatosPorMaquina(String maquina) async {
  final datasource = TroquelDatasourceImpl();
  List<Troquel> datosDesdeBD = await datasource.getAllTroquelesPorMaquina(maquina);
  setState(() {
    troqueles = datosDesdeBD;
  });
}


  // Método para importar datos desde el archivo Excel y guardarlos en ISAR
  Future<void> _importarDesdeExcel() async {
    final datasource = TroquelDatasourceImpl();
    await datasource.seleccionarArchivoExcel(hojaDeseada);

    // Después de importar, recargar los datos desde la base de datos
    _cargarDatosDesdeBaseDeDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TROQUELADORA HOLANDEZA'),
        centerTitle: true,
      ),
      body: TroquelTable(
        troqueles: troqueles,
        onImportPressed: _importarDesdeExcel,
      ),
    );
  }
}
