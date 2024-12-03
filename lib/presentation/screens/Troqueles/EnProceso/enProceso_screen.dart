import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../../providers/completados_provider.dart';
import '../../../providers/process_provider.dart';
import '../../../widgets/Tablas/in_process_table.dart';
import '../../search/troquel_search_delegate.dart';

class TroquelViewPages extends ConsumerStatefulWidget {
  const TroquelViewPages({super.key});

  @override
  TroquelViewState createState() => TroquelViewState();
}

class TroquelViewState extends ConsumerState<TroquelViewPages> {
  late Future<List<Proceso>> futureProcesos;
  late PageController _pageController;

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

  void _handleEstadoChange(Proceso proceso, Estado? newEstado) {
    final troquelNotifier = ref.read(troquelProviderInProceso.notifier);

    if (newEstado == Estado.completado) {
      // Eliminar de la tabla actual
      troquelNotifier.deleteTroquelInProcees(proceso.isarId!);

      // Agregar a la tabla de completados
      final completadosNotifier = ref.read(troquelProviderCompletados.notifier);
      completadosNotifier.addProcesoCompletado(proceso);

      // Verificar y navegar a la siguiente página si la planta es Cali
      if (proceso.planta == 'Cali') {
        print('Navegando desde página: ${_pageController.page}');
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        print('Intento de navegar a página siguiente');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final procesos = ref.watch(troquelProviderInProceso);
    final proceso = ref.watch(troquelProviderInProceso.notifier);
    final troqueles = procesos.map((proceso) => proceso.ntroquel).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Troqueles en Proceso'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
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
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay procesos en curso.'));
          } else {
            return PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                ProcesoTable(pageController: _pageController),
                const Text('Agregar al bibliaco')

                //Agregar Consumos
                //Agregar Tiempos
              ],
            );
          }
        },
      ),
    );
  }
}
