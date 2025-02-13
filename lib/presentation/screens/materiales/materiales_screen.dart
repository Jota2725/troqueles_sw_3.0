import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/materiales.dart';
import '../../../utils/input_decorations.dart';
import '../../providers/materials_provider.dart';

class MaterialesScreen extends ConsumerWidget {
  const MaterialesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();

    final TextEditingController conversionController = TextEditingController();
    Unidad? unidadSeleccionada;
    Tipo? tipoSeleccionado;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Materiales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Agregar material',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      controller: codigoController,
                                      decoration:
                                          InputDecorations.authInputDescoration(
                                        hintText: 'Ingrese codigo del material',
                                        labelText:
                                            'Ingrese el codigo del material',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor ingrese el código';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DropdownButtonFormField(
                                      dropdownColor: Colors.black,
                                      items: getDropdownItems(),
                                      onChanged: (value) {
                                        unidadSeleccionada = value;
                                      },
                                      decoration:
                                          InputDecorations.authInputDescoration(
                                              hintText: 'Seleccione la unidad',
                                              labelText: 'Selecione la unidad'),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Por favor seleccione una unidad';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      controller: descripcionController,
                                      decoration:
                                          InputDecorations.authInputDescoration(
                                        hintText:
                                            'Ingrese la descripcion del material',
                                        labelText:
                                            'Ingrese la descripcion del material',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor ingrese la descripción';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DropdownButtonFormField(
                                      dropdownColor: Colors.black,
                                      items: getDropdownItemsTipo(),
                                      onChanged: (value) {
                                        tipoSeleccionado = value;
                                      },
                                      decoration:
                                          InputDecorations.authInputDescoration(
                                              hintText:
                                                  'Seleccione el tipo de material',
                                              labelText:
                                                  'Selecione el tipo de material'),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Por favor seleccione un tipo';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      controller: conversionController,
                                      decoration:
                                          InputDecorations.authInputDescoration(
                                        hintText: 'Ingrese la conversion',
                                        labelText: 'Ingrese la conversion',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            double.tryParse(value) == null) {
                                          return 'Por favor ingrese una conversión válida';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: TextButton.icon(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          // Si el formulario es válido, mostrar el diálogo de confirmación
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.black,
                                                title:
                                                    Text("Confirmar creación"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Código: ${codigoController.text}"),
                                                    Text(
                                                        "Tipo: ${tipoSeleccionado?.name}"),
                                                    Text(
                                                        "Unidad: ${unidadSeleccionada?.name}"),
                                                    Text(
                                                        "Descripción: ${descripcionController.text}"),
                                                    Text(
                                                        "Conversión: ${conversionController.text}"),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text("Cancelar"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Cerrar el diálogo
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text("Confirmar"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Cerrar el diálogo

                                                      // Lógica para agregar el material
                                                      final addMaterial =
                                                          ref.watch(
                                                              materialProvider
                                                                  .notifier);

                                                      final newMaterial =
                                                          Materiales(
                                                        codigo: int.parse(
                                                            codigoController
                                                                .text),
                                                        tipo: tipoSeleccionado!,
                                                        unidad:
                                                            unidadSeleccionada!,
                                                        descripcion:
                                                            descripcionController
                                                                .text,
                                                        conversion: double.parse(
                                                            conversionController
                                                                .text),
                                                      );

                                                      addMaterial.addMateriales(
                                                          newMaterial);

                                                      // Limpiar los campos
                                                      codigoController.clear();
                                                      descripcionController
                                                          .clear();

                                                      conversionController
                                                          .clear();
                                                      unidadSeleccionada = null;
                                                      tipoSeleccionado = null;
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add_box_rounded,
                                        size: 30,
                                      ),
                                      label: const Text(
                                        'Crear Material',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(10.0),
                              child: const Column(
                                children: [
                                  Text(
                                    'Lista de materiales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
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
      ),
    );
  }

  List<DropdownMenuItem<Unidad>> getDropdownItems() {
    return Unidad.values
        .map((unidad) => DropdownMenuItem(
              value: unidad,
              child: Text(
                  unidad.name.toUpperCase()), // O usa toString() si prefieres
            ))
        .toList();
  }

  List<DropdownMenuItem<Tipo>> getDropdownItemsTipo() {
    return Tipo.values
        .map((tipo) => DropdownMenuItem(
              value: tipo,
              child: Text(
                  tipo.name.toUpperCase()), // O usa toString() si prefieres
            ))
        .toList();
  }
}
