import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/consumo.dart';

import '../../providers/consumos_provider.dart';
import '../../widgets/Tablas/consumo_tabla.dart';

class ConsumoScreen extends ConsumerStatefulWidget {
  const ConsumoScreen({super.key});

  @override
  _ConsumosScreenState createState() => _ConsumosScreenState();
}

class _ConsumosScreenState extends ConsumerState<ConsumoScreen> {
  late Future<List<Consumo>> futureConsumo;

  @override
  void initState() {
    super.initState();
    futureConsumo =
        _cargarDatosConsumo(); // Carga los datos al iniciar la pantalla
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<List<Consumo>> _cargarDatosConsumo() async {
    final consumoNotifier = ref.read(consumoProvider.notifier);
    await consumoNotifier.loadConsumos(); // Carga los troqueles por máquina
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return consumoNotifier.state;
    // Retorna el estado actualizado
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(
      children: [ConsumosTabla()],
    ));
  }
}


