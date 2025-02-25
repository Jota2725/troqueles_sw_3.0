// Archivo: consumos_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/consumo.dart';
import '../../../providers/consumos_provider.dart';
import '../../../providers/materials_provider.dart';
import '../../../widgets/formularios/consumos/consumos _form.dart';

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
                    ConsumosForm(
                      keyForm: keyForm ,
                      cantidadController: cantidadController,
                      selectedMaterial: selectedMaterial,
                      cliente: widget.cliente,
                      tipoTrabajo: widget.tipoTrabajo,
                    ),
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
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void _handleAddMaterial() {
    final selectedMaterial = ref.read(selectedMaterialProvider);
    if (selectedMaterial == null) {
      print('No hay material seleccionado');
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            title: const Text("Confirmar material agregado"),
            content: Text(
                ' Se va a agregar a la lista el material  ${selectedMaterial.codigo} - ${selectedMaterial.descripcion}, con la cantidad consumida de ${cantidadController.text}'),
            actions: [
              TextButton(
                  onPressed: () {
                  ref
                        .read(materialProvider.notifier)
                        .addMaterialToSelected(selectedMaterial);
                    print('Material Agregado  ${selectedMaterial.codigo} ');
                    Navigator.of(context).pop();
                    _handleFinalizeConsumptions();
                  },
                  child: const Text('Finalizar Consumos'))
            ],
          );
        });
  }

  Future<void> _handleFinalizeConsumptions() async {
    if (keyForm.currentState!.validate()) {
      final selectedMaterials =
          ref.read(materialProvider.notifier).selectedMaterials;

      if (selectedMaterials.isEmpty) {
        _addedEmptyConsuption(context);
        print('Se tiene que ingresar un consumo como mínimo');
        return;
      }

      // Preparar el objeto consumo con los materiales seleccionados
      final consumo = Consumo(
        cantidad: int.parse(cantidadController.text),
        nTroquel: widget.ntroquel,
        planta: widget.planta,
        cliente: widget.cliente,
        tipo: widget.tipoTrabajo,
      );

      for (var material in selectedMaterials) {
        consumo.materiales.add(material);
      }

      // Mostrar el diálogo con los materiales del consumo ya preparados
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            title: const Text(
              "Confirmar",
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Se van a ingresar los siguientes materiales: ',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    ...selectedMaterials.map((material) {
                      return Text(
                          'Código: ${material.codigo}, Descripción: ${material.descripcion}');
                    }),
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () async {
                  // Confirmar y guardar el consumo
                  await ref.read(consumoProvider.notifier).addConsumo(consumo);
                  ref.read(materialProvider.notifier).clearSelectedMaterials();

                  print('Se ha guardado con éxito');
                  Navigator.of(context).pop();

                  // Volver a la página principal
                  widget.pageController?.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: const Text('Confirmar',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  void _addedEmptyConsuption(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              
              title: const Text('¿Sin materiales? '),
              content: const Text(
                  'Debe ingresar como minimo un material para poder finalizar el consumo'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: const Text('Aceptaar'),
                  icon: const Icon(Icons.health_and_safety_sharp),
                ),
              ],
            ));
  }
}
