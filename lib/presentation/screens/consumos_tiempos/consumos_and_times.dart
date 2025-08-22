// lib/presentation/screens/consumos_tiempos/consumos_and_times.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';
import 'package:troqueles_sw/presentation/providers/process_provider.dart';
import 'package:troqueles_sw/presentation/providers/operario_provider.dart';

import '../../../domain/entities/materiales.dart';
import '../../../domain/entities/operario.dart';
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
    // 👉 Trae TODOS los procesos (sin filtrar por estado)
    final procesoNotifier = ref.read(procesoProvider.notifier);
    await procesoNotifier.loadProcesosAll();
    setState(() {
      procesos = ref.read(procesoProvider);
    });

    // Cargar operarios y materiales (tal como lo tenías)
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
          child: Autocomplete<Proceso>(
            displayStringForOption: (p) => p.ntroquel,
            optionsBuilder: (TextEditingValue value) {
              final query = value.text.toLowerCase();
              return procesos.where(
                (p) => p.ntroquel.toLowerCase().contains(query),
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
