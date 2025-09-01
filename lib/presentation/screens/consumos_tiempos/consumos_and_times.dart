// lib/presentation/screens/consumos_tiempos/consumos_and_times.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';
import 'package:troqueles_sw/presentation/providers/process_provider.dart';
import 'package:troqueles_sw/presentation/providers/operario_provider.dart';

import '../../widgets/formularios/tiempos/form_tiempos.dart';
import '../Troqueles/consumos/consumos_page.dart';

class ConsumosAndTimes extends ConsumerStatefulWidget {
  const ConsumosAndTimes({super.key});

  @override
  ConsumerState<ConsumosAndTimes> createState() => _ConsumosAndTimesState();
}

class _ConsumosAndTimesState extends ConsumerState<ConsumosAndTimes> {
  Proceso? selectedProceso;
  List<Proceso> procesos = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Trae TODOS los procesos (sin filtrar por estado)
    await ref.read(procesoProvider.notifier).loadProcesos();
    setState(() {
      procesos = ref.read(procesoProvider);
    });

    // Cargar operarios y materiales
    await ref.read(operarioProvider.notifier).loadOperario();
    await ref.read(materialProvider.notifier).loadMateriales();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedProcesoProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Autocomplete de troquel
              Expanded(
                child: Autocomplete<Proceso>(
                  displayStringForOption: (p) => p.ntroquel,
                  optionsBuilder: (TextEditingValue value) {
                    final q = value.text.toLowerCase();
                    return procesos.where(
                      (p) => p.ntroquel.toLowerCase().contains(q),
                    );
                  },
                  onSelected: (Proceso proceso) {
                    setState(() => selectedProceso = proceso);
                    ref.read(selectedProcesoProvider.notifier).state = proceso;
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                    return Material(
                      color: Colors.transparent,
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Seleccione un troquel',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Botón Refrescar (recarga procesos, materiales y operarios)
              ElevatedButton.icon(
                onPressed: () async {
                  await _loadData();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Datos recargados')),
                    );
                  }
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refrescar'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Row(
            children: [
              // -------- CONSUMOS --------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AbsorbPointer(
                    absorbing: selected == null,
                    child: Opacity(
                      opacity: selected == null ? 0.5 : 1.0,
                      child: ConsumosPage(
                        planta: selected?.planta ?? '',
                        cliente: selected?.cliente ?? '',
                        ntroquel: selected?.ntroquel ?? '',
                        tipoTrabajo: selected?.maquina ?? '',
                      ),
                    ),
                  ),
                ),
              ),
              // -------- TIEMPOS --------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AbsorbPointer(
                    absorbing: selected == null,
                    child: Opacity(
                      opacity: selected == null ? 0.5 : 1.0,
                      child: FormTiempos(
                        ntroquel: selected?.ntroquel ?? '',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
