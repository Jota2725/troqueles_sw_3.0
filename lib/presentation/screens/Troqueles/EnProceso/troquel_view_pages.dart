import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../../../infrastructure/datasource/isar_datasource.dart';
import '../../../providers/completados_provider.dart';
import '../../../providers/process_provider.dart';
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
  String? numeroTroquel;
  String? cliente;
  String? maquina;
  final IsarDatasource isar = IsarDatasource();

  @override
  void initState() {
    super.initState();
    futureProcesos =
        _cargarDatosEnProceso(); // Carga los datos al iniciar la pantalla
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Método para cargar los datos desde ISAR al iniciar la pantalla
  Future<List<Proceso>> _cargarDatosEnProceso() async {
    final troquelNotifier = ref.read(troquelProviderInProceso.notifier);
    await troquelNotifier
        .loadTroquelesInProcces(); // Carga los troqueles por máquina
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return troquelNotifier.state;
    // Retorna el estado actualizado
  }

  @override
  Widget build(BuildContext context) {
    final procesos = ref.watch(troquelProviderInProceso);
    final proceso = ref.watch(troquelProviderInProceso.notifier);
    final troqueles = procesos.map((proceso) => proceso.ntroquel).toList();
    final selectedTroquel = ref.watch(selectedTroquelProvider);

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
              iconAlignment: IconAlignment.end,
              label: const Text('Buscar'),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: TroquelSearchDelegate(
                    proceso: troqueles,
                    onSelected: (selected) {
                      proceso.searchTroquelInProcess(selected);
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Proceso>>(
        future: futureProcesos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                ProcesosScreen(pageController: _pageController),
                PageAddTroquel(
                  numeroTroquel: numeroTroquel,
                  cliente: cliente,
                  maquina: maquina,
                  pageController: _pageController,
                ),

                // Agregar Consumos
                // Agregar Tiempos
              ],
            );
          }
        },
      ),
    );
  }
}
