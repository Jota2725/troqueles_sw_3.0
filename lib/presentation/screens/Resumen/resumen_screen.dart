import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/general_info.dart';
import 'package:troqueles_sw/presentation/providers/general_provider.dart';

class ResumenScreen extends ConsumerStatefulWidget {
  const ResumenScreen({super.key});

  @override
  ConsumerState<ResumenScreen> createState() => _ResumenScreenState();
}

class _ResumenScreenState extends ConsumerState<ResumenScreen> {
  // Filtros
  String? _plantaSel;
  String? _clienteSel;
  final TextEditingController _troquelCtrl = TextEditingController();

  @override
  void dispose() {
    _troquelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncRows = ref.watch(generalProvider);

    // 👇 Material ancestor para que Dropdown/TextField funcionen bajo Fluent
    return Material(
      type: MaterialType.transparency,
      child: asyncRows.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (rows) {
          if (rows.isEmpty) {
            return const Center(child: Text('Sin datos para mostrar.'));
          }

          // Opciones únicas para dropdowns
          final plantas = <String>{for (final r in rows) r.planta}
            ..removeWhere((e) => e.trim().isEmpty);
          final clientes = <String>{for (final r in rows) r.cliente}
            ..removeWhere((e) => e.trim().isEmpty);

          // Aplicar filtros
          final troquelQuery = _troquelCtrl.text.trim().toLowerCase();
          final filtered = rows.where((r) {
            final byPlanta = _plantaSel == null ||
                _plantaSel!.isEmpty ||
                r.planta == _plantaSel;
            final byCliente = _clienteSel == null ||
                _clienteSel!.isEmpty ||
                r.cliente == _clienteSel;
            final byTroquel = troquelQuery.isEmpty ||
                r.ntroquel.toLowerCase().contains(troquelQuery);
            return byPlanta && byCliente && byTroquel;
          }).toList();

          // KPIs y datos de gráficos con la lista filtrada
          final totalTroqueles = filtered.length;
          final horasTotales = _sum(filtered, (r) => r.totalTiempo);
          final totalCuchiEsc = _sum(filtered, (r) => r.totalCuchiEsc);
          final bloques =
              HoursBreakdown.fromRows(filtered); // (dibCal, encEng, otras)
          final topTroqueles = TroquelHoras.fromRows(filtered, top: 10);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Encabezado + filtros
                _FiltrosHeader(
                  plantas: plantas.toList()..sort(),
                  clientes: clientes.toList()..sort(),
                  plantaSel: _plantaSel,
                  clienteSel: _clienteSel,
                  troquelCtrl: _troquelCtrl,
                  onChangePlanta: (v) => setState(
                      () => _plantaSel = (v == null || v.isEmpty) ? null : v),
                  onChangeCliente: (v) => setState(
                      () => _clienteSel = (v == null || v.isEmpty) ? null : v),
                  onChangeTroquel: (v) => setState(() {}),
                  onLimpiar: () {
                    setState(() {
                      _plantaSel = null;
                      _clienteSel = null;
                      _troquelCtrl.clear();
                    });
                  },
                ),

                const SizedBox(height: 12),

                // KPIs
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _kpiCard(
                      context,
                      title: 'Troqueles',
                      value: '$totalTroqueles',
                      icon: Icons.apps,
                      color: Colors.blue,
                    ),
                    _kpiCard(
                      context,
                      title: 'Horas totales',
                      value: horasTotales.toStringAsFixed(2),
                      icon: Icons.timer_outlined,
                      color: Colors.green,
                    ),
                    _kpiCard(
                      context,
                      title: 'Total Cuchi/Esc (cm)',
                      value: totalCuchiEsc.toStringAsFixed(0),
                      icon: Icons.straighten,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Gráficos
                Expanded(
                  child: Row(
                    children: [
                      // Pie: distribución de horas
                      Expanded(
                        child: _PieHorasCard(
                          dibCal: bloques.dibCal,
                          encEng: bloques.encEng,
                          otras: bloques.otras,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Barras: horas por troquel
                      Expanded(
                        child: _BarrasTopTroquelesCard(data: topTroqueles),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// -------------------- Barra de filtros --------------------

class _FiltrosHeader extends StatelessWidget {
  final List<String> plantas;
  final List<String> clientes;
  final String? plantaSel;
  final String? clienteSel;
  final TextEditingController troquelCtrl;
  final ValueChanged<String?> onChangePlanta;
  final ValueChanged<String?> onChangeCliente;
  final ValueChanged<String> onChangeTroquel;
  final VoidCallback onLimpiar;

  const _FiltrosHeader({
    required this.plantas,
    required this.clientes,
    required this.plantaSel,
    required this.clienteSel,
    required this.troquelCtrl,
    required this.onChangePlanta,
    required this.onChangeCliente,
    required this.onChangeTroquel,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Resumen',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: onLimpiar,
              icon: const Icon(Icons.filter_alt_off),
              label: const Text('Limpiar filtros'),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 👇 Scroll horizontal + Wrap para evitar overflow
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Planta
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<String>(
                  value: (plantaSel == null || plantaSel!.isEmpty)
                      ? null
                      : plantaSel,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Planta',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('Todas')),
                    ...plantas
                        .map((p) => DropdownMenuItem(value: p, child: Text(p))),
                  ],
                  onChanged: (v) => onChangePlanta(v == '' ? null : v),
                ),
              ),
              // Cliente
              SizedBox(
                width: 260,
                child: DropdownButtonFormField<String>(
                  value: (clienteSel == null || clienteSel!.isEmpty)
                      ? null
                      : clienteSel,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Cliente',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('Todos')),
                    ...clientes
                        .map((c) => DropdownMenuItem(value: c, child: Text(c))),
                  ],
                  onChanged: (v) => onChangeCliente(v == '' ? null : v),
                ),
              ),
              // Troquel
              SizedBox(
                width: 240,
                child: TextField(
                  controller: troquelCtrl,
                  onChanged: onChangeTroquel,
                  decoration: InputDecoration(
                    labelText: 'Buscar N° troquel',
                    border: const OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: troquelCtrl.text.isEmpty
                        ? const Icon(Icons.search)
                        : IconButton(
                            onPressed: () {
                              troquelCtrl.clear();
                              onChangeTroquel('');
                            },
                            icon: const Icon(Icons.clear),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: theme.dividerColor),
      ],
    );
  }
}

// -------------------- Helpers de cálculo --------------------

double _sum(List<GeneralInfo> rows, double Function(GeneralInfo r) sel) {
  var acc = 0.0;
  for (final r in rows) {
    acc += sel(r);
  }
  return acc;
}

class HoursBreakdown {
  final double dibCal;
  final double encEng;
  final double otras;

  HoursBreakdown({
    required this.dibCal,
    required this.encEng,
    required this.otras,
  });

  factory HoursBreakdown.fromRows(List<GeneralInfo> rows) {
    final dibCal = _sum(rows, (r) => r.totalDibCal);
    final encEng = _sum(rows, (r) => r.totalEncEng);
    final total = _sum(rows, (r) => r.totalTiempo);
    final otras = math.max(0.0, total - dibCal - encEng);
    return HoursBreakdown(dibCal: dibCal, encEng: encEng, otras: otras);
  }
}

class TroquelHoras {
  final String key;
  final double horas;
  TroquelHoras({required this.key, required this.horas});

  static List<TroquelHoras> fromRows(List<GeneralInfo> rows, {int top = 10}) {
    final list = rows
        .map((r) => TroquelHoras(key: r.ntroquel, horas: r.totalTiempo))
        .toList()
      ..sort((a, b) => b.horas.compareTo(a.horas));
    return list.take(top).toList();
  }
}

List<TroquelHoras> _topTroquelesPorHoras(List<GeneralInfo> rows,
    {int top = 10}) {
  return TroquelHoras.fromRows(rows, top: top);
}

// -------------------- Widgets UI reutilizables --------------------

Widget _kpiCard(
  BuildContext context, {
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return Container(
    width: 280,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey.shade900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          radius: 22,
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    ),
  );
}

// ----------- Pie chart card -----------

class _PieHorasCard extends StatelessWidget {
  final double dibCal;
  final double encEng;
  final double otras;

  const _PieHorasCard({
    required this.dibCal,
    required this.encEng,
    required this.otras,
  });

  @override
  Widget build(BuildContext context) {
    final total = (dibCal + encEng + otras);

    // Colores consistentes con la leyenda
    const cDibCal = Colors.blueGrey;
    const cEncEng = Colors.teal;
    const cOtras = Colors.orange;

    final sections = <PieChartSectionData>[
      PieChartSectionData(
        value: dibCal,
        color: cDibCal,
        title:
            total == 0 ? '' : '${(dibCal / total * 100).toStringAsFixed(1)}%',
        radius: 70,
      ),
      PieChartSectionData(
        value: encEng,
        color: cEncEng,
        title:
            total == 0 ? '' : '${(encEng / total * 100).toStringAsFixed(1)}%',
        radius: 70,
      ),
      PieChartSectionData(
        value: otras,
        color: cOtras,
        title: total == 0 ? '' : '${(otras / total * 100).toStringAsFixed(1)}%',
        radius: 70,
      ),
    ];

    return _card(
      context,
      title: 'Distribución de horas',
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: sections,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _legend(context, const [
            LegendItem('Dib/Cal', cDibCal),
            LegendItem('Enc/Eng', cEncEng),
            LegendItem('Otras', cOtras),
          ]),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

// ----------- Bar chart card -----------

class _BarrasTopTroquelesCard extends StatelessWidget {
  final List<TroquelHoras> data;
  const _BarrasTopTroquelesCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final groups = <BarChartGroupData>[];
    for (var i = 0; i < data.length; i++) {
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data[i].horas,
              width: 18,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return _card(
      context,
      title: 'Top troqueles por horas',
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
        child: BarChart(
          BarChartData(
            barGroups: groups,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    final idx = value.toInt();
                    if (idx < 0 || idx >= data.length) return const SizedBox();
                    final label = data[idx].key;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------- Card scaffold used by charts -----------

Widget _card(BuildContext context,
    {required String title, required Widget child}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey.shade900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Expanded(child: child),
      ],
    ),
  );
}

class LegendItem {
  final String label;
  final Color color;
  const LegendItem(this.label, this.color);
}

Widget _legend(BuildContext context, List<LegendItem> items) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: items
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 12, height: 12, color: e.color),
                const SizedBox(width: 6),
                Text(e.label, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        )
        .toList(),
  );
}
