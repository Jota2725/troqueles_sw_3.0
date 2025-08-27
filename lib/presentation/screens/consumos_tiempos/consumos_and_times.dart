// lib/presentation/screens/consumos_tiempos/consumos_and_times.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';
import 'package:troqueles_sw/presentation/providers/process_provider.dart';
import 'package:troqueles_sw/presentation/providers/operario_provider.dart';

import '../../widgets/formularios/tiempos/form_tiempos.dart';
import '../Troqueles/consumos/consumos_page.dart';
import 'package:troqueles_sw/presentation/providers/sync_provider.dart';

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
    await ref.read(procesoProvider.notifier).loadProcesos(); // <— ahora “todos”
    setState(() {
      procesos = ref.read(procesoProvider);
    });

    await ref.read(operarioProvider.notifier).loadOperario();
    await ref.read(materialProvider.notifier).loadMateriales();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedProcesoProvider);
    final syncing = ref.watch(syncControllerProvider);

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

              // 👉 Botón "Sincronizar ahora"
              ElevatedButton.icon(
                onPressed: syncing
                    ? null
                    : () async {
                        await ref
                            .read(syncControllerProvider.notifier)
                            .syncNow();
                        // Actualiza la lista local por si cambió
                        setState(() {
                          procesos = ref.read(procesoProvider);
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sincronización completada'),
                            ),
                          );
                        }
                      },
                icon: Icon(syncing ? Icons.sync : Icons.cloud_sync),
                label: Text(syncing ? 'Sincronizando…' : 'Sincronizar'),
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
