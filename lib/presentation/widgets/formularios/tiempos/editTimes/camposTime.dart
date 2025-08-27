import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';
import 'package:troqueles_sw/presentation/widgets/formularios/tiempos/controllers/tiemposFormControllers.dart';

class EditTiempos extends ConsumerStatefulWidget {
  final Tiempos tiempos;
  const EditTiempos({super.key, required this.tiempos});

  @override
  ConsumerState<EditTiempos> createState() => _EditTiemposState();
}

class _EditTiemposState extends ConsumerState<EditTiempos> {
  late Tiemposformcontrollers formController;

  @override
  void initState() {
    formController = Tiemposformcontrollers(widget.tiempos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
        title: Text("Editar tiempo"),
        content: ActualizarTiempoFormulario(
          controller: formController,
        ),
        actions: [
          Button(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF141414))),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Button(
              child: Text("Actualizar"),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF0BAFFE))),
              onPressed: () async {
                if (!formController.validateFields(context)) return;

                final nuevoTiempos = formController.buildTiempos();
                final timeProvidern = ref.read(timeProvider.notifier);

                nuevoTiempos.isarId = widget.tiempos.isarId;
                await timeProvidern.updateTiempo(nuevoTiempos);
                Navigator.pop(context);
              }),
        ]);
  }
}

class ActualizarTiempoFormulario extends StatefulWidget {
  final Tiemposformcontrollers controller;
  const ActualizarTiempoFormulario({super.key, required this.controller});

  @override
  State<ActualizarTiempoFormulario> createState() =>
      _ActualizarTiempoFormularioState();
}

class _ActualizarTiempoFormularioState
    extends State<ActualizarTiempoFormulario> {
  @override
  Widget build(BuildContext context) {
    Widget buildComboBox({
      required String label,
      required String? selectedValue,
      required List<String> items,
      required ValueChanged<String?> onChanged,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(
            width: double.infinity, // Ocupa todo el ancho disponible
            child: ComboBox<String>(
              placeholder: Text(label),
              value: selectedValue,
              items: items
                  .map(
                    (item) => ComboBoxItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      );
    }

    Widget buildtextfield(String label, String key) {
      return Column(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextBox(
            controller: widget.controller.controllers[key],
          )
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildtextfield("fecha", "fecha"),
        SizedBox(
          height: 20,
        ),
        buildtextfield("Numero Troquel", "Numero Troquel"),
        SizedBox(
          height: 20,
        ),
        buildtextfield("Operario", "Operario"),
        SizedBox(
          height: 20,
        ),
        buildtextfield("Tiempo", "Tiempo"),
        SizedBox(
          height: 20,
        ),
        buildComboBox(
            label: "Actividad",
            selectedValue: widget.controller.selectedActividad,
            items: [
              'Calado',
              'Dibujo',
              'Encuchillado',
              'Prueba',
              'Empaque',
              'Punteado',
              'Serrapid',
              'Engomado'
            ],
            onChanged: (value) {
              setState(() {
                widget.controller.selectedActividad = value;
              });
            })
      ],
    );
  }
}
