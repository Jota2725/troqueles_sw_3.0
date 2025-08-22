import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

import '../../providers/completados_provider.dart';
import '../../providers/process_provider.dart';
import '../widgets.dart';

// Ajusta esta ruta si tu archivo se llama diferente o está en otra carpeta:
import '../formularios/Enproceso/add_precesos.dart';

class TablaEnProceso extends ConsumerWidget {
  const TablaEnProceso({
    super.key,
    required this.procesos,
    required this.pageController,
  });

  final PageController? pageController;
  final List<Proceso> procesos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  color: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.blue.withOpacity(0.3);
                    }
                    return rowColor;
                  }),
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
                      _EstadoDropdownCell(
                        proceso: proceso,
                        onCompleted: () async {
                          // 1) Marca completado (actualiza en Isar)
                          await ref
                              .read(troquelProviderCompletados.notifier)
                              .addProcesoCompletado(proceso);

                          // 2) Guarda para la pantalla de agregar siguiente (como tenías)
                          ref.read(selectedTroquelProvider.notifier).state = {
                            'numeroTroquel': proceso.ntroquel,
                            'cliente': proceso.cliente,
                            'maquina': proceso.maquina,
                          };

                          // 3) Si la planta es CALI, avanza de página
                          if (proceso.planta == "CALI") {
                            pageController?.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }

                          // 4) Refresca lista de “en proceso”
                          await ref.read(procesoProvider.notifier).loadProcesos(
                                estado: Estado.enProceso,
                              );
                        },
                        onChangedOther: (nuevoEstado) async {
                          // Para cambios a otros estados, actualiza el proceso
                          final actualizado = Proceso(
                            ntroquel: proceso.ntroquel,
                            fechaIngreso: proceso.fechaIngreso,
                            fechaEstimada: proceso.fechaEstimada,
                            planta: proceso.planta,
                            cliente: proceso.cliente,
                            maquina: proceso.maquina,
                            ingeniero: proceso.ingeniero,
                            observaciones: proceso.observaciones,
                            estado: nuevoEstado,
                          )..isarId = proceso.isarId;

                          await ref
                              .read(procesoProvider.notifier)
                              .updateProceso(actualizado);
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
                                builder: (BuildContext context) {
                                  return AddProcesos(proceso: proceso);
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            tooltip: 'Eliminar',
                            onPressed: () async {
                              await ref
                                  .read(procesoProvider.notifier)
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

/// Dropdown especializado para manejar el cambio de estado
class _EstadoDropdownCell extends StatelessWidget {
  final Proceso proceso;
  final Future<void> Function() onCompleted;
  final Future<void> Function(Estado nuevoEstado) onChangedOther;

  const _EstadoDropdownCell({
    super.key,
    required this.proceso,
    required this.onCompleted,
    required this.onChangedOther,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Estado>(
      value: proceso.estado,
      items: Estado.values.map<DropdownMenuItem<Estado>>((Estado estado) {
        return DropdownMenuItem<Estado>(
          value: estado,
          child: Text(estado.name, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
      onChanged: (newEstado) async {
        if (newEstado == null) return;

        if (newEstado == Estado.completado) {
          await onCompleted();
        } else {
          await onChangedOther(newEstado);
        }
      },
      underline: Container(height: 1, color: Colors.grey),
      isExpanded: true,
    );
  }
}
