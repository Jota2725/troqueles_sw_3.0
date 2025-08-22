import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart'; // Para usar Estado y Proceso
import '../../providers/process_provider.dart';
import '../../widgets/widgets.dart';

// Rutas correctas:
import '../../widgets/formularios/Enproceso/add_precesos.dart';
import '../../widgets/Tablas/proceso_table.dart';

class ProcesosScreen extends ConsumerWidget {
  final PageController pageController;

  const ProcesosScreen({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final procesos = ref.watch(procesoProvider);
    final procesoNotifier = ref.watch(procesoProvider.notifier);

    return Column(
      children: [
        ActionsIcons(
          actions: [
            ActionIcon(
              label: 'Agregar',
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AddProcesos(),
                );
              },
            ),
            ActionIcon(
              label: 'Refrescar',
              icon: const Icon(Icons.refresh_outlined),
              onPressed: () => procesoNotifier.loadProcesos(
                estado: Estado.enProceso, // ✅ ahora usa el método correcto
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: TablaEnProceso(
              procesos: procesos,
              pageController: pageController,
            ),
          ),
        ),
      ],
    );
  }
}
