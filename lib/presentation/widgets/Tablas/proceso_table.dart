import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../providers/completados_provider.dart';
import '../../providers/process_provider.dart';
import '../../providers/selection_provider.dart';

import '../widgets.dart';
import '../formularios/Enproceso/add_precesos.dart';

class TablaEnProceso extends ConsumerWidget {
  const TablaEnProceso({
    super.key,
    required this.procesos,
    required this.pageController,
  });

  final List<Proceso> procesos;
  final PageController? pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final procesoNotifier = ref.watch(procesoProvider.notifier);

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 100,
        child: Material(
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: 12,
              horizontalMargin: 5,
              dividerThickness: 1,
              sortColumnIndex: 0,
              sortAscending: true,
              columns: const <DataColumn>[
                DataColumn(
                    label: DataColums(icon: Icons.numbers, text: 'Troquel')),
                DataColumn(
                    label: DataColums(
                        icon: Icons.calendar_today, text: 'Ingreso')),
                DataColumn(
                    label:
                        DataColums(icon: Icons.date_range, text: 'Estimada')),
                DataColumn(
                    label:
                        DataColums(icon: Icons.location_city, text: 'Planta')),
                DataColumn(
                    label: DataColums(icon: Icons.person, text: 'Cliente')),
                DataColumn(
                    label: DataColums(icon: Icons.settings, text: 'Máquina')),
                DataColumn(
                    label:
                        DataColums(icon: Icons.engineering, text: 'Ingeniero')),
                DataColumn(
                    label:
                        DataColums(icon: Icons.comment, text: 'Observaciones')),
                DataColumn(label: DataColums(icon: Icons.flag, text: 'Estado')),
                DataColumn(label: DataColums(text: 'Acciones')),
              ],
              rows: procesos.map<DataRow>((proceso) {
                final rowColor = proceso.estado == Estado.enProceso
                    ? Colors.yellow.withOpacity(0.3)
                    : proceso.estado == Estado.suspendido
                        ? Colors.red.withOpacity(0.3)
                        : Colors.green.withOpacity(0.3);

                return DataRow(
                  color: WidgetStateProperty.resolveWith<Color?>(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.blue.withOpacity(0.3)
                        : rowColor,
                  ),
                  cells: <DataCell>[
                    DataCell(Text(proceso.ntroquel)),
                    DataCell(Text(
                        '${proceso.fechaIngreso.toLocal()}'.split(' ')[0])),
                    DataCell(Text(
                        '${proceso.fechaEstimada?.toLocal()}'.split(' ')[0])),
                    DataCell(Text(proceso.planta)),
                    DataCell(Text(proceso.cliente)),
                    DataCell(Text(proceso.maquina)),
                    DataCell(Text(proceso.ingeniero)),
                    DataCell(Text(proceso.observaciones)),
                    DataCell(
                      DropdownCell(
                        proceso: proceso,
                        currentValue: proceso.estado,
                        onChanged: (newEstado) async {
                          if (newEstado == null) return;

                          // 1) Actualiza el estado en BD y refresca la lista filtrada
                          await procesoNotifier.updateEstado(
                              proceso, newEstado);

                          // 2) Si quedó como completado, refresca el provider de completados
                          if (newEstado == Estado.completado) {
                            await ref
                                .read(troquelProviderCompletados.notifier)
                                .loadTroquelesCompletados();

                            // Guarda selección para la otra pantalla
                            ref.read(selectedTroquelProvider.notifier).state = {
                              'numeroTroquel': proceso.ntroquel,
                              'cliente': proceso.cliente,
                              'maquina': proceso.maquina,
                            };

                            // Si la planta es CALI, navega a la siguiente página
                            if (proceso.planta == "CALI") {
                              pageController?.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Editar',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AddProcesos(proceso: proceso),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            tooltip: 'Eliminar',
                            onPressed: () async {
                              await procesoNotifier
                                  .deleteProceso(proceso.isarId!);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownCell extends StatelessWidget {
  final Estado currentValue;
  final Proceso proceso;
  final ValueChanged<Estado?> onChanged;
  final VoidCallback? onComplete;

  const DropdownCell({
    super.key,
    required this.currentValue,
    required this.onChanged,
    required this.proceso,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Estado>(
      value: currentValue,
      items: Estado.values
          .map((estado) => DropdownMenuItem<Estado>(
                value: estado,
                child: Text(estado.name, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
      onChanged: (newEstado) {
        onChanged(newEstado);
        if (newEstado == Estado.completado) onComplete?.call();
      },
      underline: Container(height: 1, color: Colors.grey),
      isExpanded: true,
    );
  }
}
