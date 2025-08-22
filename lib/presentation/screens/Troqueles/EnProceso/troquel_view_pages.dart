import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';

import '../../../providers/completados_provider.dart'; // contiene selectedTroquelProvider
import '../../../providers/process_provider.dart'; // nuevo procesoProvider
import '../../../widgets/search/troquel_search_delegate.dart';

import '../../procesos/procesos_screen.dart';
import 'pages_addtroquel.dart';

class TroquelViewPages extends ConsumerStatefulWidget {
  const TroquelViewPages({super.key});

  @override
  TroquelViewState createState() => TroquelViewState();
}

class TroquelViewState extends ConsumerState<TroquelViewPages> {
  late Future<List<Proceso>> futureProcesos;
  late PageController _pageController;

  // (Opcional) todavía lo tienes instanciado aquí, pero ya no lo usamos directo en este widget
  final IsarDatasource isar = IsarDatasource();

  @override
  void initState() {
    super.initState();
    futureProcesos = _cargarDatosEnProceso(); // carga inicial
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Cargar procesos únicamente en estado "enProceso" para esta pantalla.
  Future<List<Proceso>> _cargarDatosEnProceso() async {
    final notifier = ref.read(procesoProvider.notifier);
    await notifier.loadProcesos(estado: Estado.enProceso);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return notifier.state;
  }

  @override
  Widget build(BuildContext context) {
    final procesos = ref.watch(procesoProvider);
    final selectedTroquel = ref.watch(selectedTroquelProvider);

    // lista simple de N° troquel para el buscador
    final troqueles = procesos.map((p) => p.ntroquel).toList();

    final numeroTroquel = selectedTroquel['numeroTroquel'] ?? 'Desconocido';
    final cliente = selectedTroquel['cliente'] ?? 'Desconocido';
    final maquina = selectedTroquel['maquina'] ?? 'Desconocido';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Troqueles en Proceso'),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.search),
            label: const Text('Buscar'),
            onPressed: () async {
              final selected = await showSearch<String>(
                context: context,
                delegate: TroquelSearchDelegate(
                  proceso: troqueles,
                  onSelected: (value) {}, // no usamos el callback interno
                ),
              );

              if (selected == null) return;

              // Buscar el proceso seleccionado en la lista actual
              final match = procesos.where((p) => p.ntroquel == selected);
              if (match.isNotEmpty) {
                final p = match.first;

                // Guardar seleccionado para usarlo en PageAddTroquel
                ref.read(selectedTroquelProvider.notifier).state = {
                  'numeroTroquel': p.ntroquel,
                  'cliente': p.cliente,
                  'maquina': p.maquina,
                };

                // Navegar a la segunda página (form)
                if (mounted) {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              } else {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'No se encontró el troquel seleccionado en la lista actual.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Proceso>>(
        future: futureProcesos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Mostrar siempre el PageView; la primera página lee del provider
          return PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: [
              // Página 0: listado de procesos en proceso
              ProcesosScreen(pageController: _pageController),

              // Página 1: agregar/editar usando el seleccionado
              PageAddTroquel(
                numeroTroquel: numeroTroquel,
                cliente: cliente,
                maquina: maquina,
                pageController: _pageController,
              ),
            ],
          );
        },
      ),
    );
  }
}
