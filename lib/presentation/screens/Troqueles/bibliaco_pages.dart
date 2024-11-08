import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';
import '../../../domain/entities/troquel.dart';
import '../../../infrastructure/datasource/isar_datasource.dart';
import '../../../infrastructure/datasource/troquel_datasource.dart';


class BibliacoPages extends StatefulWidget {
  static const name = 'bibliaco_pages';
  const BibliacoPages({super.key});

  @override
  _BibliacoPagesState createState() => _BibliacoPagesState();
}

class _BibliacoPagesState extends State<BibliacoPages> {
  final String hojaDeseada = 'WA'; // Nombre de la hoja deseada en este caso
  List<Troquel> troqueles = [];

  @override
  void initState() {
    super.initState();
    _cargarDatosDesdeBaseDeDatosPorMaquina(hojaDeseada); // Carga los datos al iniciar la pantalla
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<void> _cargarDatosDesdeBaseDeDatos() async {
    final datasource = IsarDatasource();
    List<Troquel> datosDesdeBD = await datasource.getAllTroquelesPorMaquina(hojaDeseada);

    setState(() {
      troqueles = datosDesdeBD;
    });
  }

void _cargarDatosDesdeBaseDeDatosPorMaquina(String maquina) async {
  final datasource = IsarDatasource();
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
    _cargarDatosDesdeBaseDeDatosPorMaquina(hojaDeseada);
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
        onImportPressed: _importarDesdeExcel, maquina: hojaDeseada,
       
        
      ),
    );
  }
}
