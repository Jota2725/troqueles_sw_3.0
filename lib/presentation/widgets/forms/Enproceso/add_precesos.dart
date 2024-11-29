import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/presentation/widgets/forms/Enproceso/campos/buildFields.dart';
import '../../../providers/process_provider.dart';

import 'controllers/procesos_form.dart';


class AddProcesos extends ConsumerStatefulWidget {
  final Proceso? proceso;
  const AddProcesos({super.key, this.proceso});

  @override
  ConsumerState<AddProcesos> createState() => _AddProcesosState();
}

class _AddProcesosState extends ConsumerState<AddProcesos> {
  late ProcesoFormController formController;

  @override
  void initState() {
    super.initState();
    formController = ProcesoFormController(widget.proceso);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.proceso == null
          ? 'Agregar troquel en proceso'
          : 'Editar troquel en proceso'),
      content: SingleChildScrollView(
        child: ProcesoFields(
          controller: formController,
        ),
      ),
      actions: [
        Button(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF141414))),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Button(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF0BAFFE))),
          child: Text(widget.proceso == null ? 'Agregar' : 'Guardar'),
          onPressed: () async {
            if (!formController.validateFields(context)) return;

            final nuevoProceso = formController.buildProceso();
            final troquelNotifierInProceso =
                ref.read(troquelProviderInProceso.notifier);

            if (widget.proceso == null) {
              await troquelNotifierInProceso.addTroquelInProceso(nuevoProceso);
            } else {
              nuevoProceso.isarId = widget.proceso!.isarId;
              await troquelNotifierInProceso.updateTroquel(nuevoProceso);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
