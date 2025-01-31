import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../providers/process_provider.dart';
import '../../widgets/formularios/tiempos/form_tiempos.dart';
import '../../widgets/widgets.dart';
import '../Troqueles/consumos/consumos_page.dart';

class ConsumosAndTimes extends ConsumerWidget {
  const ConsumosAndTimes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProceso = ref.watch(selectedProcesoProvider);

    final procesos = ref.watch(troquelProviderInProceso);

    return Column(
      children: [
        _TablaEnProceso(
          procesos: procesos,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: selectedProceso != null
                        ? ConsumosPage(
                            planta: selectedProceso.planta,
                            cliente: selectedProceso.cliente,
                            ntroquel: selectedProceso.ntroquel,
                            tipoTrabajo: selectedProceso.maquina,
                          )
                        : const Center(
                            child: Text(
                            'Seleccione un proceso para mostrar los detalles.',
                            style: TextStyle(color: Colors.white),
                          )))),
            Expanded(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FormTiempos(ntroquel: selectedProceso?.ntroquel ?? ''),
            )),
          ],
        )
      ],
    );
  }
}

class _TablaEnProceso extends ConsumerStatefulWidget {
  const _TablaEnProceso({
    required this.procesos,
  });

  final List<Proceso> procesos;

  @override
  ConsumerState<_TablaEnProceso> createState() => _TablaEnProcesoState();
}

class _TablaEnProcesoState extends ConsumerState<_TablaEnProceso> {
  Proceso? selectedProceso;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Material(
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 15, // Reduce el espacio entre columnas
            horizontalMargin: 5,
            dividerThickness: 1,
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const <DataColumn>[
              DataColumn(
                  label: DataColums(icon: Icons.numbers, text: 'Troquel')),
              DataColumn(
                  label:
                      DataColums(icon: Icons.calendar_today, text: 'Ingreso')),
              DataColumn(
                  label: DataColums(icon: Icons.date_range, text: 'Estimada')),
              DataColumn(
                  label: DataColums(icon: Icons.location_city, text: 'Planta')),
              DataColumn(
                  label: DataColums(icon: Icons.person, text: 'Cliente')),
              DataColumn(
                  label: DataColums(icon: Icons.settings, text: 'Máquina')),
              DataColumn(
                  label:
                      DataColums(icon: Icons.engineering, text: 'Ingeniero')),
            ],
            rows: widget.procesos.map<DataRow>((proceso) {
              // Determinar color según el estado del proceso
              final rowColor = proceso.estado == Estado.enProceso
                  ? Colors.yellow.withOpacity(0.3)
                  : proceso.estado == Estado.suspendido
                      ? Colors.red.withOpacity(0.3)
                      : Colors.green.withOpacity(0.3);

              return DataRow(
                selected: selectedProceso == proceso,
                onSelectChanged: (isSelected) {
                  setState(() {
                    selectedProceso = isSelected == true ? proceso : null;
                  });
                  if (isSelected == true) {
                    ref.read(selectedProcesoProvider.notifier).state = proceso;

                    // Mostrar la información seleccionada en consola (o manejarla como desees)
                    debugPrint('Información seleccionada: ${proceso.cliente}');
                  }
                },
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
                      Text('${proceso.fechaEstimada?.toLocal()}'.split(' ')[0])),
                  DataCell(Text(proceso.planta)),
                  DataCell(Text(proceso.cliente)),
                  DataCell(Text(proceso.maquina)),
                  DataCell(Text(proceso.ingeniero)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
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
