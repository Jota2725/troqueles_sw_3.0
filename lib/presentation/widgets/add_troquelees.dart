import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

import '../providers/troqueles_provider.dart';

class AddTroquelees extends ConsumerStatefulWidget {
  final Troquel? troquel;
  const AddTroquelees({super.key, this.troquel});

  @override
  ConsumerState<AddTroquelees> createState() => _AddTroqueleesState();
}

class _AddTroqueleesState extends ConsumerState<AddTroquelees> {
  String? selectedValue;
  final ubicacionController = TextEditingController();
  final gicoController = TextEditingController();
  final clienteController = TextEditingController();
  final referenciaController = TextEditingController();
  final claveController = TextEditingController();
  final altoController = TextEditingController();
  final anchoController = TextEditingController();
  final largoController = TextEditingController();
  final cabidaController = TextEditingController();
  final estiloController = TextEditingController();
  final descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.troquel != null) {
      final troquel = widget.troquel!;
      ubicacionController.text = troquel.ubicacion.toString();
      gicoController.text = troquel.gico.toString();
      clienteController.text = troquel.cliente;
      referenciaController.text = troquel.referencia.toString();
      selectedValue = troquel.maquina;
      claveController.text = troquel.clave.toString();
      anchoController.text = ' ${troquel.ancho.toString()} ';
      altoController.text = '${troquel.alto.toString()} ';
      largoController.text = '${troquel.largo}';
      cabidaController.text = troquel.cabida.toString();
      estiloController.text = troquel.estilo.toString();
      descripcionController.text = troquel.descripcion.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.troquel == null ? 'Agregar troquel' : 'Editar troquel'),
      backgroundColor: FluentTheme.of(context).brightness == Brightness.light
          ? const Color(0xFFF5F5F5)
          : const Color(0xFF1E1E1E),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'A continuación ingrese toda la información del Troquel'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ubicacionController,
                    decoration: const InputDecoration(
                      labelText: 'Ingresa la ubicación',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: gicoController,
                    decoration: const InputDecoration(
                      labelText: 'Ingresa el GICO',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(
                labelText: 'Ingresa el cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: referenciaController,
              decoration: const InputDecoration(
                labelText: 'Ingresa el número CAD',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ComboBox<String>(
                      placeholder: Text(
                        selectedValue ?? 'Máquina',
                        style: FluentTheme.of(context).typography.body,
                      ),
                      value: selectedValue,
                      items: const [
                        ComboBoxItem(value: 'WA', child: Text('WARD')),
                        ComboBoxItem(value: 'TW', child: Text('HOLANDEZA')),
                        ComboBoxItem(value: 'FW', child: Text('FLEXOWARD')),
                        ComboBoxItem(value: 'ML', child: Text('MINILINE')),
                        ComboBoxItem(value: 'DF', child: Text('DONFANG')),
                        ComboBoxItem(value: 'JS', child: Text('JS MACHINE')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }
                      // Contenido del formulario...
                      ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: claveController,
                    decoration: const InputDecoration(
                      labelText: 'Ingrese la Clave',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: largoController,
                    decoration: const InputDecoration(
                      labelText: 'Largo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: anchoController,
                    decoration: const InputDecoration(
                      labelText: 'Ancho',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: altoController,
                    decoration: const InputDecoration(
                      labelText: 'Alto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cabidaController,
                    decoration: const InputDecoration(
                      labelText: 'Cabida',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: estiloController,
                    decoration: const InputDecoration(
                      labelText: 'Estilo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  // Verificar campos...
                  final nuevoTroquel = Troquel(
                    ubicacion: ubicacionController.text,
                    gico: int.parse(gicoController.text),
                    cliente: clienteController.text,
                    referencia: int.parse(referenciaController.text),
                    maquina: selectedValue!,
                    clave: claveController.text,
                    alto: int.parse(altoController.text),
                    ancho: int.parse(anchoController.text),
                    largo: int.parse(largoController.text),
                    cabida: int.parse(cabidaController.text),
                    estilo: estiloController.text,
                    descripcion: descripcionController.text,
                  );

                  final troquelNotifier = ref.read(troquelProvider.notifier);

                  if (widget.troquel == null) {
                    await troquelNotifier.addTroquel(nuevoTroquel);
                  } else {
                    nuevoTroquel.isarId = widget.troquel!.isarId;
                    await troquelNotifier.updateTroquel(nuevoTroquel);
                  }

                  Navigator.of(context).pop();
                },
                child: Text(widget.troquel == null ? 'Agregar' : 'Guardar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
