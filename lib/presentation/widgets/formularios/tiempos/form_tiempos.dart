import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:troqueles_sw/presentation/widgets/forms/Bibliaco/texfields_widgtes.dart';
import '../../../../domain/entities/operario.dart';
import '../../../../domain/entities/tiempos.dart';
import '../../../../utils/input_decorations.dart';
import '../../../providers/operario_provider.dart';
import '../../../providers/process_provider.dart';

import '../../../providers/timepos_provider.dart';
import '../../search/search_operario.dart';

class FormTiempos extends ConsumerWidget {
  const FormTiempos({super.key, required String ntroquel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Actividad? actividadSeleccionada;
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size.width;
    final selectedProceso = ref.watch(selectedProcesoProvider);

    final TextEditingController timeController = TextEditingController();
    final selectedOpeer = ref.watch(selectedOperarioProvider);
    DateTime now = DateTime.now();
    String fromattedDate = DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddOperarios();
                    });
              },
              label: Text('Agregar nuevo operario'))
        ],
        title: Text('TIEMPOS - ${selectedProceso?.ntroquel} '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size * 0.5,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    CustomTextField(
                        label: 'Fecha',
                        value: fromattedDate,
                        enabled: false),

                    const SizedBox(
                      height: 10,
                    ),
                    const SearchOperario(),
                    const SizedBox(
                      height: 10,
                    ),
                    //NOMBRE
                    CustomTextField(
                      enabled: false,
                      value: selectedOpeer?.nombre ?? 'Sin nombre',
                      label: 'Operario',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //ACTIVIDAD

                    DropdownButtonFormField(
                      
                      items: getDropdownItemsActivity(),
                      onChanged: (value) {
                        actividadSeleccionada = value;
                      },
                      decoration: InputDecorations.authInputDescoration(
                          hintText: 'Seleccione la actividad',
                          labelText: 'Selecione la actividad'),
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
                    //HORAS
                    //OBSERVACION
                    TextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecorations.authInputDescoration(
                        hintText: 'Ingrese el tiempo en horas',
                        labelText: 'Tiempo (horas)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el tiempo correspondiente';
                        }
                        final num? tiempo = num.tryParse(value);
                        if (tiempo == null || tiempo <= 0) {
                          return 'Ingrese un tiempo válido en horas';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.blueGrey),
                      ),
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.white),
                      onPressed: () async {
                        if (keyForm.currentState!.validate()) {
                          final newtiempo = Tiempos(
                              fecha: fromattedDate,
                              tiempo: double.parse(timeController.text),
                              actividad: actividadSeleccionada!,
                              ntroquel: selectedProceso!.ntroquel,
                              operarios: selectedOpeer!.nombre);

                          await ref
                              .read(timeProvider.notifier)
                              .addTiempos(newtiempo);
                        }
                      },
                      label: const Text(
                        'Agregar Tiempo',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  List<DropdownMenuItem<Actividad>> getDropdownItemsActivity() {
    return Actividad.values
        .map((unidad) => DropdownMenuItem(
              value: unidad,
              child: Text(
                  unidad.name.toUpperCase()), // O usa toString() si prefieres
            ))
        .toList();
  }
}

class AddOperarios extends ConsumerStatefulWidget {
  const AddOperarios({super.key});

  @override
  _AddOperariosState createState() => _AddOperariosState();
}

class _AddOperariosState extends ConsumerState<AddOperarios> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fichaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar nuevo operario'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del diálogo
          children: [
            // Campo de Ficha (Solo números)
            TextFormField(
              controller: _fichaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ficha',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una ficha válida';
                }
                if (int.tryParse(value) == null) {
                  return 'Solo números permitidos';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Campo de Nombre
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un nombre válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Botón Guardar
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final operario = Operario(
                      ficha: int.tryParse(_fichaController.text)!,
                      nombre: _nombreController.text);
                  await ref
                      .read(operarioProvider.notifier)
                      .addNewOperarios(operario);
                  // Aquí puedes manejar el guardado del operario
                  print('Ficha: ${_fichaController.text}');
                  print('Nombre: ${_nombreController.text}');

                  Navigator.of(context).pop(); // Cierra el diálogo
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fichaController.dispose();
    _nombreController.dispose();
    super.dispose();
  }
}
