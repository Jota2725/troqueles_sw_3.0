import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../providers/process_provider.dart';
import '../widgets.dart';

class ProcesoTable extends ConsumerWidget {
  const ProcesoTable({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final procesos = ref.watch(troquelProviderInProceso);
    final proceso = ref.watch(troquelProviderInProceso.notifier);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ActionsIcons(
            searchBar: const CustomSearchBar(''),
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
          _TablaEnProceso(procesos: procesos),
        ],
      ),
    );
  }
}

class _TablaEnProceso extends StatelessWidget {
  const _TablaEnProceso({
    required this.procesos,
  });

  final List<Proceso> procesos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 100,
      child: Material(
        child: DataTable(
          columnSpacing: 12, // Reduce el espacio entre columnas
          horizontalMargin: 5,
          dividerThickness: 1,
          sortColumnIndex: 0,
          sortAscending: true,
          columns: const <DataColumn>[
            DataColumn(label: DataColums(icon: Icons.numbers, text: 'Troquel')),
            DataColumn(
                label: DataColums(icon: Icons.calendar_today, text: 'Ingreso')),
            DataColumn(
                label: DataColums(icon: Icons.date_range, text: 'Estimada')),
            DataColumn(
                label: DataColums(icon: Icons.location_city, text: 'Planta')),
            DataColumn(label: DataColums(icon: Icons.person, text: 'Cliente')),
            DataColumn(
                label: DataColums(icon: Icons.settings, text: 'Máquina')),
            DataColumn(
                label: DataColums(icon: Icons.engineering, text: 'Ingeniero')),
            DataColumn(
                label: DataColums(icon: Icons.comment, text: 'Observaciones')),
            DataColumn(label: DataColums(icon: Icons.flag, text: 'Estado')),
            DataColumn(label: DataColums(text: 'Acciones')),
          ],
          rows: procesos.map<DataRow>((proceso) {
            // Determinar color según el estado del proceso
            final rowColor = proceso.estado == Estado.enProceso
                ? Colors.yellow.withOpacity(0.3)
                : proceso.estado == Estado.suspendido
                    ? Colors.red.withOpacity(0.3)
                    : Colors.green.withOpacity(0.3);

            return DataRow(
              color: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.blue.withOpacity(0.3);
                }
                return rowColor;
              }),
              cells: <DataCell>[
                DataCell(Text(proceso.ntroquel)),
                DataCell(
                    Text('${proceso.fechaIngreso.toLocal()}'.split(' ')[0])),
                DataCell(
                    Text('${proceso.fechaEstimada.toLocal()}'.split(' ')[0])),
                DataCell(Text(proceso.planta)),
                DataCell(Text(proceso.cliente)),
                DataCell(Text(proceso.maquina)),
                DataCell(Text(proceso.ingeniero)),
                DataCell(Text(proceso.observaciones)),
                DataCell(
                  DropdownCell(
                    currentValue: proceso.estado,
                    onChanged: (newEstado) {},
                  ),
                ),
                DataCell(Row(
                  children: [
                    IconButton(
                      tooltip: 'Editar',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddProcesos(proceso: proceso);
                            });
                        // Acción de editar
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      tooltip: 'Eliminar',
                      onPressed: () {
                        // Acción de eliminar
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DropdownCell extends StatelessWidget {
  final Estado currentValue;
  final ValueChanged<Estado?> onChanged;

  const DropdownCell({
    super.key,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Estado>(
      value: currentValue,
      items: Estado.values.map<DropdownMenuItem<Estado>>((Estado estado) {
        return DropdownMenuItem<Estado>(
          value: estado,
          child: Text(
            estado.name,
            style: const TextStyle(fontSize: 12), // Tamaño reducido
          ),
        );
      }).toList(),
      onChanged: onChanged,
      underline:
          Container(height: 1, color: Colors.grey), // Línea bajo el dropdown
      isExpanded: true, // Expande el dropdown dentro de la celda
    );
  }
}

class WrapTextCell extends StatelessWidget {
  final String text;

  const WrapTextCell({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Text(
        text,
        softWrap: true,
        maxLines: null,
        overflow: TextOverflow.visible,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
