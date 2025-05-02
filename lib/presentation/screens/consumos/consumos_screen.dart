import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/consumo.dart';
import '../../providers/consumos_provider.dart';
import '../../widgets/Tablas/consumo_tabla.dart';
import '../../widgets/scaled_text.dart'; // Importar ScaledText

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
    futureConsumo = _cargarDatosConsumo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Consumo>> _cargarDatosConsumo() async {
    final consumoNotifier = ref.read(consumoProvider.notifier);
    await consumoNotifier.loadConsumos();
    return consumoNotifier.state;
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Puedes agregar un encabezado si deseas
          // ScaledText('Consumos por máquina', style: TextStyle(fontWeight: FontWeight.bold)),
          ConsumosTabla(),
        ],
      ),
    );
  }
}
