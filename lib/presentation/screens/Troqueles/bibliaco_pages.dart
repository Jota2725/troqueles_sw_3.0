import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/Tablas/custom_table_widget.dart';
import '../../../domain/entities/troquel.dart';
import '../../../infrastructure/datasource/troquel_datasource.dart';
import '../../providers/troqueles_provider.dart';

class BibliacoPages extends ConsumerStatefulWidget {
  final String titulo;
  final String hojaDeseada;
  static const name = 'bibliaco_pages';

  const BibliacoPages({super.key, required this.titulo, required this.hojaDeseada});

  @override
  _BibliacoPagesState createState() => _BibliacoPagesState();
}

class _BibliacoPagesState extends ConsumerState<BibliacoPages> {
  late Future<List<Troquel>> futureTroqueles;

  @override
  void initState() {
    super.initState();
    futureTroqueles = _cargarDatosDesdeBaseDeDatosPorMaquina(widget.hojaDeseada); // Carga los datos al iniciar la pantalla
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<List<Troquel>> _cargarDatosDesdeBaseDeDatosPorMaquina(String maquina) async {
    final troquelNotifier = ref.read(troquelProvider.notifier);
    await troquelNotifier.loadTroqueles(maquina);  // Carga los troqueles por máquina
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return troquelNotifier.state; // Retorna el estado actualizado
  }

  // Método para importar datos desde el archivo Excel y guardarlos en ISAR
  Future<void> _importarDesdeExcel() async {
    final datasource = TroquelDatasourceImpl();
    await datasource.seleccionarArchivoExcel(widget.hojaDeseada);

    // Recarga los datos después de importar desde Excel
    setState(() {
      futureTroqueles = _cargarDatosDesdeBaseDeDatosPorMaquina(widget.hojaDeseada);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Troquel>>(
        future: futureTroqueles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else  {
          
            return TroquelTable(
             
              onImportPressed: () async {
                await _importarDesdeExcel();
              },
              maquina: widget.hojaDeseada,
            );
          }
        },
      ),
    );
  }
}
