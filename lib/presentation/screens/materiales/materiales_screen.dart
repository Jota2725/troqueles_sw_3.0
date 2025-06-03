import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/materiales.dart';
import '../../providers/materials_provider.dart';
import '../../widgets/scaled_text.dart';
import '../../widgets/formularios/materiales/material_form_dialog.dart';
import '../../widgets/formularios/materiales/editar_material_dialog.dart';

class MaterialesScreen extends ConsumerWidget {
  const MaterialesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(materialProvider);

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
                      final materialNotifier =
                          ref.read(materialProvider.notifier);
                      await materialNotifier
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
                label: const ScaledText('Importar Excel'),
              ),
            ),

            const SizedBox(height: 10),

            /// Lista de materiales que ocupa todo el espacio restante
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ScaledText(
                      'Lista de materiales',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: materiales.isEmpty
                          ? const Center(
                              child:
                                  ScaledText("No hay materiales registrados."))
                          : ListView.builder(
                              itemCount: materiales.length,
                              itemBuilder: (_, index) {
                                final m = materiales[index];
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title:
                                        Text('${m.codigo} - ${m.descripcion}'),
                                    subtitle: Text(
                                        'Tipo: ${m.tipo.name}, Unidad: ${m.unidad.name}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Conv.: ${m.conversion}'),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          tooltip: 'Editar',
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  EditarMaterialDialog(
                                                material: m,
                                              ),
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
