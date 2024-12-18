import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/input_decorations.dart';
import '../../../providers/materials_provider.dart';
import '../../../widgets/search_materials.dart'; // Asegúrate de importar correctamente tus clases y dependencias.

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
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController conversionController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();

  final GlobalKey<FormState> keyForm = GlobalKey();



  @override
  void dispose() {
    // Limpiar controladores al destruir el widget
    descripcionController.dispose();
    tipoController.dispose();
    conversionController.dispose();
    cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMaterial =
        ref.watch(materialProvider.notifier).selectedMaterial;




    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedMaterial != null) {
        setState(() {
          descripcionController.text = selectedMaterial.descripcion;
          tipoController.text = selectedMaterial.tipo.name;
          conversionController.text = selectedMaterial.conversion.toString();
        });
      }
    });

    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar consumos al troquel ${widget.ntroquel}'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
                    // Textos superiores centrados
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
                    const SizedBox(height: 20),

                    // Formulario
                    Center(
                      child: Form(
                        key: keyForm,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size * 0.5,
                            child: Column(
                              children: [
                                const SearchMaterials(),
                                const SizedBox(height: 10),
                                TextFormField(
                                  enabled: false,
                                  controller: descripcionController,
                                  decoration:
                                      InputDecorations.authInputDescoration(
                                    hintText: 'Descripcion',
                                    labelText: 'Descripcion',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  enabled: false,
                                  controller: tipoController,
                                  decoration:
                                      InputDecorations.authInputDescoration(
                                    hintText: 'Tipo',
                                    labelText: 'Tipo',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  enabled: false,
                                  controller: conversionController,
                                  decoration:
                                      InputDecorations.authInputDescoration(
                                    hintText: 'Conversión',
                                    labelText: 'Conversion',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: cantidadController,
                                  decoration:
                                      InputDecorations.authInputDescoration(
                                    hintText: 'Cantidad',
                                    labelText: 'Cantidad',
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Botones centrados
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blueGrey)),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          label: const Text('Agregar Material',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        const SizedBox(width: 10),
                        FilledButton.icon(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Finalizar Consumos',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
