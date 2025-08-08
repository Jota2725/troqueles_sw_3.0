import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';
import 'package:troqueles_sw/presentation/widgets/formularios/tiempos/editTimes/camposTime.dart';
import 'package:flutter/services.dart';

class TiemposTabla extends ConsumerWidget {
  // 🔹 Clave global para acceder al estado
  static final GlobalKey<_TablaTiemposState> tablaKey =
      GlobalKey<_TablaTiemposState>();

  const TiemposTabla({super.key});

  // 🔹 Método estático para copiar desde fuera
  static void copiarTodosDesdeFuera(BuildContext context) {
    final state = tablaKey.currentState;
    if (state != null) {
      state.copiarTodosLosTiempos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo copiar: tabla no encontrada')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiemposNotifier = ref.watch(timeProvider.notifier);
    final tiempos = ref.watch(timeProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          TablaTiempos(
            key: tablaKey, // 🔹 Asignamos la clave aquí
            tiempos: tiempos,
            tiemposNotifier: tiemposNotifier,
          )
        ],
      ),
    );
  }
}

class TablaTiempos extends StatefulWidget {
  final List<Tiempos> tiempos;
  final TiemposNotifier tiemposNotifier;

  const TablaTiempos({
    super.key,
    required this.tiempos,
    required this.tiemposNotifier,
  });

  @override
  State<TablaTiempos> createState() => _TablaTiemposState();
}

class _TablaTiemposState extends State<TablaTiempos> {
  void copiarTodosLosTiempos() {
    final filas = widget.tiempos.map((tiempo) {
      return [
        tiempo.fecha,
        tiempo.ntroquel,
        tiempo.operarios ?? '',
        tiempo.ficha ?? '',
        tiempo.tiempo.toString(),
        tiempo.actividad.name,
      ].join('\t');
    }).join('\n');

    Clipboard.setData(ClipboardData(text: filas));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Todos los tiempos copiados al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        child: PaginatedDataTable(
          showEmptyRows: false,
          showFirstLastButtons: true,
          columns: const [
            DataColumn(label: Text('Copiar')),
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('N° de troquel')),
            DataColumn(label: Text('Operario')),
            DataColumn(label: Text('Ficha')),
            DataColumn(label: Text('Tiempo (hr)')),
            DataColumn(label: Text('Actividad')),
            DataColumn(label: Text('Editar/Borrar')),
          ],
          source: _TimposDataSource(
            tiempos: widget.tiempos,
            context: context,
            troquelNotifier: widget.tiemposNotifier,
          ),
          rowsPerPage: 15,
        ),
      ),
    );
  }
}

class _TimposDataSource extends DataTableSource {
  final List<Tiempos> tiempos;
  final BuildContext context;
  final TiemposNotifier troquelNotifier;

  _TimposDataSource({
    required this.tiempos,
    required this.context,
    required this.troquelNotifier,
  });

  @override
  DataRow getRow(int index) {
    final tiempo = tiempos[index];

    return DataRow(cells: [
      DataCell(
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            final rowData = [
              tiempo.fecha,
              tiempo.ntroquel,
              tiempo.operarios ?? '',
              tiempo.ficha ?? '',
              tiempo.tiempo.toString(),
              tiempo.actividad.name,
            ];
            Clipboard.setData(ClipboardData(text: rowData.join('\t')));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fila copiada al portapapeles')),
            );
          },
        ),
      ),
      DataCell(Text(tiempo.fecha)),
      DataCell(Text(tiempo.ntroquel)),
      DataCell(Text(tiempo.operarios ?? '')),
      DataCell(Text(tiempo.ficha ?? '')),
      DataCell(Text('${tiempo.tiempo}')),
      DataCell(Text(tiempo.actividad.name)),
      DataCell(Row(
        children: [
          IconButton(
            tooltip: 'Editar Tiempo',
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditTiempos(tiempos: tiempo),
              );
            },
          ),
          IconButton(
            tooltip: 'Eliminar Tiempo',
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('¿Eliminar tiempo?'),
                  content: const Text(
                      'Esta acción no se puede deshacer. ¿Estás seguro de que deseas eliminar este registro de tiempo?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await troquelNotifier.deleteTiempos(tiempo.isarId!);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tiempo eliminado'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiempos.length;

  @override
  int get selectedRowCount => 0;
}
