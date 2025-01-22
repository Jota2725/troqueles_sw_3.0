import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/process_provider.dart';
import '../../widgets/widgets.dart';

class ProcesosScreen extends ConsumerWidget {
  final PageController pageController;

  const ProcesosScreen({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final procesos = ref.watch(troquelProviderInProceso);
    final proceso = ref.watch(troquelProviderInProceso.notifier);
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
                      builder: (BuildContext context) {
                        return const AddProcesos();
                      });
                }),
            ActionIcon(
                label: 'Refrescar',
                icon: const Icon(Icons.refresh_outlined),
                onPressed: () => proceso.loadTroquelesInProcces()),
          ],
        ),
        TablaEnProceso(
          procesos: procesos,
          pageController: pageController,
        ),
      ],
    );
  }
}
