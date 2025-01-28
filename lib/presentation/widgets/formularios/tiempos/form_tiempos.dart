import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/widgets/forms/Bibliaco/texfields_widgtes.dart';
import '../../../../utils/input_decorations.dart';
import '../../../providers/process_provider.dart';

import '../../search/search_operario.dart';

class FormTiempos extends ConsumerWidget {
  const FormTiempos({super.key, required String ntroquel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size.width;
    final selectedProceso = ref.watch(selectedProcesoProvider);

    return Scaffold(
      appBar: AppBar(
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
                    InputDatePickerFormField(
                        firstDate: DateTime(2023, 1, 1),
                        lastDate: DateTime(2030, 1, 1)),

                    const SizedBox(
                      height: 10,
                    ),
                    const SearchOperario(),
                    const SizedBox(
                      height: 10,
                    ),
                    //NOMBRE
                    const CustomTextField(
                      enabled: false,
                      value: 'Operario',
                      label: 'Operario',
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //ACTIVIDAD
                    DropdownButtonFormField(
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Actividad',
                          labelText: 'Actividad',
                        ),
                        items: const [DropdownMenuItem(child: Text(''))],
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    //HORAS
                    //OBSERVACION
                    TextFormField(
                      
                      enabled: true,
                      controller: TextEditingController(),
                      decoration: InputDecorations.authInputDescoration(
                        hintText: 'Tiempo',
                        labelText: 'Tiempo',


                      ),
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
                      onPressed: () {

                        
                       


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
}
