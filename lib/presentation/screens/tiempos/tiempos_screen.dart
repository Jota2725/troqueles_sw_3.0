import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';
import 'package:troqueles_sw/presentation/widgets/Tablas/tiempos_tabla.dart';

class TiemposScreen extends ConsumerStatefulWidget {
  const TiemposScreen({super.key});

  @override
  _TiemposScreenState createState() => _TiemposScreenState();
}

class _TiemposScreenState extends ConsumerState<TiemposScreen> {
  late Future<void> futureTiempos;

  @override
  void initState() {
    super.initState();
    futureTiempos = _cargarDatosTiempos();
  }

  Future<void> _cargarDatosTiempos() async {
    await ref.read(timeProvider.notifier).loadTiempos();
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
                'Tiempos registrados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text('Copiar todo'),
                onPressed: () {
                  TiemposTabla.copiarTodosDesdeFuera(
                      context); // 🔹 Ahora siempre funciona
                },
              ),
            ],
          ),
        ),
        const Expanded(child: TiemposTabla()),
      ],
    );
  }
}
