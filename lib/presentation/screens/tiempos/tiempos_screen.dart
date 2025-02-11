import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';
import 'package:troqueles_sw/presentation/widgets/Tablas/tiempos_tabla.dart';

import '../../../domain/entities/tiempos.dart';

class TiemposScreen extends ConsumerStatefulWidget {
  const TiemposScreen({super.key});

  @override
  _TiemposScreenState createState() => _TiemposScreenState();
}

class _TiemposScreenState extends ConsumerState<TiemposScreen> {
  late Future<List<Tiempos>> futureTiempos;


  @override
  void initState() {
    super.initState();
    futureTiempos =
        _cargarDatosTiempos (); // Carga los datos al iniciar la pantalla
    
  }
  @override
  void dispose() {
    super.dispose();
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<List<Tiempos>> _cargarDatosTiempos() async {
    final tiemposNotifier = ref.read(timeProvider.notifier);
    await tiemposNotifier
        .loadTiempos(); // Carga los troqueles por máquina
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return tiemposNotifier.state;
    // Retorna el estado actualizado
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: const [TiemposTabla()],));
  }
}
