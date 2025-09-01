// consumos_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/consumo.dart';
import '../../../providers/consumos_provider.dart';
import '../../../providers/materials_provider.dart';
import '../../../widgets/formularios/consumos/consumos_form.dart';

class ConsumosPage extends ConsumerStatefulWidget {
  const ConsumosPage({
    super.key,
    required this.planta,
    required this.ntroquel,
    required this.cliente,
    required this.tipoTrabajo,
    this.pageController,
  });

  final PageController? pageController;
  final String ntroquel;
  final String cliente;
  final String tipoTrabajo;
  final String planta;

  @override
  ConsumerState<ConsumosPage> createState() => _ConsumosPageState();
}

class _ConsumosPageState extends ConsumerState<ConsumosPage> {
  final TextEditingController cantidadController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMaterial = ref.watch(selectedMaterialProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('TROQUEL ${widget.ntroquel} - ${widget.planta}'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Refrescar consumos',
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ref.read(consumoProvider.notifier).loadConsumos();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Consumos recargados')),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ConsumosForm(
                  keyForm: keyForm,
                  planta: widget.planta,
                  cantidadController: cantidadController,
                  selectedMaterial: selectedMaterial,
                  cliente: widget.cliente,
                  tipoTrabajo: widget.tipoTrabajo,
                ),
                const SizedBox(height: 16),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return FilledButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
      ),
      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
      onPressed: _handleAddMaterial,
      label: const Text(
        'Agregar Material',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _handleAddMaterial() {
    final selectedMaterial = ref.read(selectedMaterialProvider);
    if (selectedMaterial == null) {
      _showSnack('Primero selecciona un material.');
      return;
    }
    if (cantidadController.text.trim().isEmpty) {
      _showSnack('Escribe la cantidad consumida.');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar material agregado"),
          content: Text(
            'Se agregará:  ${selectedMaterial.codigo} - '
            '${selectedMaterial.descripcion}\n'
            'Cantidad: ${cantidadController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(materialProvider.notifier)
                    .addMaterialToSelected(selectedMaterial);
                Navigator.of(context).pop();
                _handleFinalizeConsumptions();
              },
              child: const Text('Finalizar Consumos'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleFinalizeConsumptions() async {
    if (!keyForm.currentState!.validate()) return;

    final selectedMaterials =
        ref.read(materialProvider.notifier).selectedMaterials;

    if (selectedMaterials.isEmpty) {
      _addedEmptyConsuption(context);
      return;
    }

    // Preparamos el consumo (NO añadimos materiales al IsarLinks)
    final consumo = Consumo(
      cantidad: int.parse(cantidadController.text),
      nTroquel: widget.ntroquel,
      planta: widget.planta,
      cliente: widget.cliente,
      tipo: widget.tipoTrabajo,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Se van a ingresar los siguientes materiales:'),
                const SizedBox(height: 10),
                ...selectedMaterials.map(
                  (m) => Text(
                    'Código: ${m.codigo}, Descripción: ${m.descripcion}',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final mats = List.of(
                      ref.read(materialProvider.notifier).selectedMaterials);

                  await ref
                      .read(consumoProvider.notifier)
                      .addConsumoWithMaterials(consumo, mats);

                  ref.read(materialProvider.notifier).clearSelectedMaterials();
                  cantidadController.clear();

                  if (mounted) {
                    Navigator.of(context).pop();
                    _showSnack('Consumo registrado');
                  }

                  widget.pageController?.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } catch (e) {
                  if (mounted) _showSnack('Error al registrar: $e');
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _addedEmptyConsuption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¿Sin materiales?'),
        content: const Text(
          'Debes ingresar como mínimo un material para finalizar el consumo.',
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.check),
            label: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
