import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/materiales.dart';
import '../../providers/materials_provider.dart';
import '../../providers/materiales_filters.dart';
import '../../widgets/scaled_text.dart';
import '../../widgets/formularios/materiales/material_form_dialog.dart';
import '../../widgets/formularios/materiales/editar_material_dialog.dart';

class MaterialesScreen extends ConsumerStatefulWidget {
  const MaterialesScreen({super.key});

  @override
  ConsumerState<MaterialesScreen> createState() => _MaterialesScreenState();
}

class _MaterialesScreenState extends ConsumerState<MaterialesScreen> {
  late final TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController(
      text: ref.read(materialSearchProvider),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lista **filtrada** con búsqueda + tipo
    final materiales = ref.watch(filteredMaterialesProvider);

    // Para UI/estilo
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Valor actual del filtro Tipo (null = Todos)
    final tipoSel = ref.watch(materialTipoFilterProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// Barra superior con título y botón
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ScaledText(
                  'Materiales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const MaterialFormDialog(),
                    );
                  },
                  icon: const Icon(Icons.add_box_rounded),
                  label: const ScaledText('Añadir Material'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Botón de importar Excel
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () async {
                  final materialesDatasource =
                      ref.read(materialesDatasourceProvider);
                  try {
                    final materialesImportados = await materialesDatasource
                        .seleccionarArchivoExcel('Data');
                    if (materialesImportados.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: ScaledText(
                              'Se importaron ${materialesImportados.length} materiales correctamente.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      await ref
                          .read(materialProvider.notifier)
                          .addMaterialesFromList(materialesImportados);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: ScaledText('No se importaron materiales.'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: ScaledText('Error al importar materiales: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.upload),
                label: const ScaledText(''),
              ),
            ),

            const SizedBox(height: 10),

            /// 🔎 Barra de búsqueda + filtro de tipo
            Row(
              children: [
                // Buscador
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Buscar por código, descripción, unidad o tipo',
                      border: const OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: (_searchCtrl.text.isEmpty)
                          ? null
                          : IconButton(
                              tooltip: 'Limpiar',
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchCtrl.clear();
                                ref
                                    .read(materialSearchProvider.notifier)
                                    .state = '';
                                setState(() {});
                              },
                            ),
                    ),
                    onChanged: (txt) {
                      ref.read(materialSearchProvider.notifier).state = txt;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Filtro por tipo
                SizedBox(
                  width: 260,
                  child: DropdownButtonFormField<Tipo?>(
                    value: tipoSel,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de material',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: <DropdownMenuItem<Tipo?>>[
                      const DropdownMenuItem<Tipo?>(
                        value: null,
                        child: Text('Todos'),
                      ),
                      ...Tipo.values.map(
                        (t) => DropdownMenuItem<Tipo?>(
                          value: t,
                          child: Text(t.name),
                        ),
                      ),
                    ],
                    onChanged: (nuevo) {
                      ref.read(materialTipoFilterProvider.notifier).state =
                          nuevo;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Lista de materiales (contenedor)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScaledText(
                      'Lista de materiales (${materiales.length})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: materiales.isEmpty
                          ? const Center(
                              child:
                                  ScaledText("No hay materiales registrados."),
                            )
                          : ListView.builder(
                              itemCount: materiales.length,
                              itemBuilder: (_, index) {
                                final m = materiales[index];
                                return Card(
                                  color: isDark
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade100,
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(
                                      '${m.codigo} - ${m.descripcion}',
                                      style: TextStyle(
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Tipo: ${m.tipo.name}, Unidad: ${m.unidad.name}',
                                      style: TextStyle(
                                        color:
                                            theme.textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Conv.: ${m.conversion}',
                                          style: TextStyle(
                                            color: theme
                                                .textTheme.bodySmall?.color,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          tooltip: 'Editar',
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  EditarMaterialDialog(
                                                      material: m),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          tooltip: 'Eliminar',
                                          onPressed: () async {
                                            final confirm =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    "Confirmar eliminación"),
                                                content: Text(
                                                    "¿Eliminar el material '${m.descripcion}'?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            ctx, false),
                                                    child:
                                                        const Text("Cancelar"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            ctx, true),
                                                    child:
                                                        const Text("Eliminar"),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (confirm == true) {
                                              await ref
                                                  .read(
                                                      materialProvider.notifier)
                                                  .deleteMaterial(m);
                                              if (!mounted) return;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Material '${m.descripcion}' eliminado."),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
