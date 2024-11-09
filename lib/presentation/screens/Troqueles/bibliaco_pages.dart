import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';
import '../../../domain/entities/troquel.dart';
import '../../../infrastructure/datasource/isar_datasource.dart';
import '../../../infrastructure/datasource/troquel_datasource.dart';

class BibliacoPages extends StatefulWidget {
  final String titulo;
  final String hojaDeseada;
  static const name = 'bibliaco_pages';

  const BibliacoPages(
      {super.key, required this.titulo, required this.hojaDeseada});

  @override
  // ignore: library_private_types_in_public_api
  _BibliacoPagesState createState() => _BibliacoPagesState();
}

class _BibliacoPagesState extends State<BibliacoPages> {
  // Nombre de la hoja deseada en este caso
  late Future<List<Troquel>>  futureTroqueles ;

  @override
  void initState() {
    super.initState();
    futureTroqueles = _cargarDatosDesdeBaseDeDatosPorMaquina(
        widget.hojaDeseada); // Carga los datos al iniciar la pantalla
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  /*Future<void> _cargarDatosDesdeBaseDeDatos() async {
    final datasource = IsarDatasource();
    List<Troquel> datosDesdeBD = await datasource.getAllTroquelesPorMaquina(widget.hojaDeseada);

    setState(() {
      troqueles = datosDesdeBD;
    });
  }
  */

   Future<List<Troquel>> _cargarDatosDesdeBaseDeDatosPorMaquina(String maquina) async {
    final datasource = IsarDatasource();
    return await datasource.getAllTroquelesPorMaquina(maquina);
  }

  // Método para importar datos desde el archivo Excel y guardarlos en ISAR
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.titulo),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Troquel>>(
        future: futureTroqueles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras los datos están cargando, muestra un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else  {
            // Cuando los datos están listos, muestra la tabla
            return TroquelTable(
              troqueles: snapshot.data!,
              onImportPressed: () async {
                // Aquí puedes recargar los datos después de importar desde Excel
                await _importarDesdeExcel();
              },
              maquina: widget.hojaDeseada,
            );
          }
        },
      ),
    );
  }


   Future<void> _importarDesdeExcel() async {
    final datasource = TroquelDatasourceImpl();
    await datasource.seleccionarArchivoExcel(widget.hojaDeseada);

    setState(() {
      futureTroqueles = _cargarDatosDesdeBaseDeDatosPorMaquina(widget.hojaDeseada);
    });
  }
}
