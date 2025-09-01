import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/consumos_provider.dart';
import '../../providers/consumos_provider_table.dart'
    show consumoTablaProvider, ConsumoTablaNotifier;
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
    await ref.read(consumoProvider.notifier).loadConsumos(); // opcional
    await ref.read(consumoTablaProvider.notifier).refresh(); // tabla plana
  }

  void _copiarTodo() {
    final rows = ref.read(consumoTablaProvider);
    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay datos para copiar')),
      );
      return;
    }
    final buf = StringBuffer();
    buf.writeln([
      'Planta',
      'Cliente',
      'N° Troquel',
      'Código',
      'Cantidad',
      'Conversión',
      'Unidad',
      'Descripción',
      'Tipo',
    ].join('\t'));

    for (final r in rows) {
      String s(String k) => (r[k] ?? '').toString();
      buf.writeln([
        s('planta'),
        s('cliente'),
        s('ntroquel'),
        s('codigo'),
        s('cantidad'),
        s('conversion'),
        s('unidad'),
        s('descripcion'),
        s('tipo'),
      ].join('\t'));
    }
    Clipboard.setData(ClipboardData(text: buf.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Consumos copiados al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tablaRows = ref.watch(consumoTablaProvider);

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
              Row(
                children: [
                  IconButton(
                    tooltip: 'Refrescar',
                    icon: const Icon(Icons.refresh),
                    onPressed: () =>
                        ref.read(consumoTablaProvider.notifier).refresh(),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar todo'),
                    onPressed: _copiarTodo,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Renderiza la tabla (si hay datos se ven filas; si no, sólo headers)
        const Expanded(child: ConsumosTabla()),
      ],
    );
  }
}
