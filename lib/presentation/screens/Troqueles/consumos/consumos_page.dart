// Archivo: consumos_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/consumo.dart';
import '../../../../domain/entities/materiales.dart';
import '../../../../utils/input_decorations.dart';
import '../../../providers/consumos_provider.dart';
import '../../../providers/materials_provider.dart';
import '../../../widgets/search_materials.dart';

class ConsumosPage extends ConsumerStatefulWidget {
  const ConsumosPage({
    super.key,
    required this.ntroquel,
    required this.cliente,
    required this.tipoTrabajo,
    required this.pageController,
  });

  final PageController pageController;
  final String ntroquel;
  final String cliente;
  final String tipoTrabajo;

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
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar consumos al troquel ${widget.ntroquel}'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _confirmExit(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildClientAndJobInfo(),
                    const SizedBox(height: 20),
                    _buildForm(size, selectedMaterial),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientAndJobInfo() {
    return Column(
      children: [
        Text(
          'CLIENTE : ${widget.cliente}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'TIPO DE TRABAJO : ${widget.tipoTrabajo}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(double size, Materiales? selectedMaterial) {
    return Form(
      key: keyForm,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size * 0.5,
          child: Column(
            children: [
              const SearchMaterials(),
              const SizedBox(height: 10),
              _buildDisabledTextField('Descripción',
                  selectedMaterial?.descripcion ?? 'Sin descripción'),
              const SizedBox(height: 10),
              _buildDisabledTextField(
                  'Tipo', selectedMaterial?.tipo.name ?? 'Sin tipo'),
              const SizedBox(height: 10),
              _buildDisabledTextField('Conversión',
                  selectedMaterial?.conversion.toString() ?? 'Sin conversión'),
              const SizedBox(height: 10),
              TextFormField(
                controller: cantidadController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Cantidad',
                  labelText: 'Cantidad',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una cantidad';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledTextField(String label, String value) {
    return TextFormField(
      enabled: false,
      controller: TextEditingController(text: value),
      decoration: InputDecorations.authInputDescoration(
        hintText: label,
        labelText: label,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
          ),
          icon: const Icon(Icons.add_circle_outline, color: Colors.white),
          onPressed: _handleAddMaterial,
          label: const Text(
            'Agregar Material',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        FilledButton.icon(
          icon: const Icon(Icons.send, color: Colors.white),
          onPressed: _handleFinalizeConsumptions,
          label: const Text(
            'Finalizar Consumos',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _handleAddMaterial() {
    final selectedMaterial = ref.read(selectedMaterialProvider);
    if (selectedMaterial == null) {
      print('No hay material seleccionado');
      return;
    }
    ref.read(materialProvider.notifier).addMaterialToSelected(selectedMaterial);
    print('Material Agregado  ${selectedMaterial.codigo} ');
  }

  Future<void> _handleFinalizeConsumptions() async {
    if (keyForm.currentState!.validate()) {
      final selectedMaterials =
          ref.read(materialProvider.notifier).selectedMaterials;
      if (selectedMaterials.isEmpty) {
        print('Se tiene que ingresar un consumo como mínimo');
        return;
      }

      final consumo = Consumo(
        int.parse(cantidadController.text),
        nTroquel: widget.ntroquel,
        cliente: widget.cliente,
        tipo: widget.tipoTrabajo,
      );

      for (var material in selectedMaterials) {
        consumo.materiales.add(material);
      }

      await ref.read(consumoProvider.notifier).addConsumo(consumo);
      ref.read(materialProvider.notifier).clearSelectedMaterials();
      print('Se ha guardado con éxito');

      widget.pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Está seguro?'),
          actions: [
            TextButton.icon(
              label: const Text('Salir'),
              onPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: const Text('Permanecer'),
              icon: const Icon(Icons.health_and_safety_sharp),
            ),
          ],
        );
      },
    );
  }
}
