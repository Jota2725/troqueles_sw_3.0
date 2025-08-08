import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/consumos_provider.dart';
import '../../widgets/Tablas/consumo_tabla.dart';

class ConsumoScreen extends ConsumerStatefulWidget {
  const ConsumoScreen({super.key});

  @override
  _ConsumosScreenState createState() => _ConsumosScreenState();
}

class _ConsumosScreenState extends ConsumerState<ConsumoScreen> {
  late Future<void> futureConsumo;

  @override
  void initState() {
    super.initState();
    futureConsumo = _cargarDatosConsumo();
  }

  Future<void> _cargarDatosConsumo() async {
    await ref.read(consumoProvider.notifier).loadConsumos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Consumos por troquel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text('Copiar todo'),
                onPressed: () {
                  ConsumosTabla.copiarTodosDesdeFuera(
                      context); // 🔹 Llama al método estático
                },
              ),
            ],
          ),
        ),
        const Expanded(child: ConsumosTabla()),
      ],
    );
  }
}
