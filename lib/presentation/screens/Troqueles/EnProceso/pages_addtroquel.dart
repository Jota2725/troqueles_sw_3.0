import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/presentation/providers/troqueles_provider.dart';
import '../../../../utils/input_decorations.dart';

class PageAddTroquel extends ConsumerStatefulWidget {
  final PageController pageController;
  final String numeroTroquel;
  final String cliente;
  final String maquina;

  const PageAddTroquel({
    super.key,
    required this.pageController,
    required this.numeroTroquel,
    required this.cliente,
    required this.maquina,
  });

  @override
  _PageAddTroquelState createState() => _PageAddTroquelState();
}

class _PageAddTroquelState extends ConsumerState<PageAddTroquel> {
  late final TextEditingController numeroTroquelController;
  late final TextEditingController clienteController;
  late final TextEditingController maquinaController;
  final TextEditingController referenciaController = TextEditingController();
  final TextEditingController largoController = TextEditingController();
  final TextEditingController anchoController = TextEditingController();
  final TextEditingController altoController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController cabidaController = TextEditingController();
  final TextEditingController estiloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey();

  @override
  void initState() {
    super.initState();
    numeroTroquelController = TextEditingController(text: widget.numeroTroquel);
    clienteController = TextEditingController(text: widget.cliente);
    maquinaController = TextEditingController(text: widget.maquina);
  }

  @override
  void dispose() {
    numeroTroquelController.dispose();
    clienteController.dispose();
    maquinaController.dispose();
    referenciaController.dispose();
    largoController.dispose();
    anchoController.dispose();
    altoController.dispose();
    cabidaController.dispose();
    estiloController.dispose();
    descripcionController.dispose();
    claveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              label: Text('Guardar'),
              onPressed: () async {
                final addbibliaco = ref.watch(troquelProvider.notifier);
                if (keyForm.currentState!.validate()) {
                  final nuevoTroquel = Troquel(
                      gico: int.parse(numeroTroquelController.text),
                      cliente: clienteController.text,
                      referencia: int.parse(referenciaController.text),
                      maquina: maquinaController.text,
                      alto: int.parse(altoController.text),
                      ancho: int.parse(anchoController.text),
                      largo: int.parse(largoController.text),
                      cabida: int.parse(cabidaController.text),
                      clave: claveController.text,
                      descripcion: descripcionController.text,
                      estilo: estiloController.text,
                      ubicacion: '' );


                  await addbibliaco.addTroquel(nuevoTroquel);
                  widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                }

                //AGREGAR AL Bibliaco
                
              },
              icon: Icon(Icons.save),
            ),
          )
        ],
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
        title: const Text('Agregar a Bibliaco'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: size * 0.5,
          child: Column(
            children: [
              const Text(
                  'A continuación ingrese toda la información del troquel nuevo'),
              const SizedBox(height: 10),
              Form(
                key: keyForm,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size * 0.5,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: numeroTroquelController,
                          enabled: false,
                          decoration: InputDecorations.authInputDescoration(
                            hintText: '3678',
                            labelText: 'Numero de troquel',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: clienteController,
                          enabled: false,
                          decoration: InputDecorations.authInputDescoration(
                              hintText: 'Plasticos Rimax', labelText: 'Cliente'),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: referenciaController,
                          decoration: InputDecorations.authInputDescoration(
                            hintText: 'Ingrese la referencia del troquel',
                            labelText: 'Referencia CAD',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la referencia';
                            }
                            if (double.tryParse(value) == null) {
                              return 'la referencia debe ser un valor numerico';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: maquinaController,
                          enabled: false,
                          decoration: InputDecorations.authInputDescoration(
                              hintText: 'Holandeza', labelText: 'Maquina'),
                        ),
                        TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Ingrese la clave del troquel';
                            }
                            return null;
                          },
                          controller: claveController,
                          decoration: InputDecorations.authInputDescoration(
                              hintText: 'Ingrese la clave', labelText: 'Clave'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: largoController,
                                decoration: InputDecorations.authInputDescoration(
                                  hintText: 'Ingrese el largo del troquel',
                                  labelText: 'Largo',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese el largo del troquel';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'el largo debe de ser un valor numerico';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: anchoController,
                                decoration: InputDecorations.authInputDescoration(
                                  hintText: 'Ingrese el ancho del troquel',
                                  labelText: 'Ancho',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese el ancho del troquel';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'el ancho debe de ser un valor numerico';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: altoController,
                                decoration: InputDecorations.authInputDescoration(
                                  hintText: 'Ingrese el Alto del troquel',
                                  labelText: 'Alto',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese el alto del troquel';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'el alto debe de ser un valor numerico';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: cabidaController,
                          decoration: InputDecorations.authInputDescoration(
                            hintText: 'Ingrese la cabida del troquel',
                            labelText: 'Cabida',
                          ),
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
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: estiloController,
                          decoration: InputDecorations.authInputDescoration(
                            hintText: 'Ingrese el estilo del troquel',
                            labelText: 'Estilo',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: descripcionController,
                          decoration: InputDecorations.authInputDescoration(
                            hintText: 'Ingrese una descripcion del troquel',
                            labelText: 'Descripcion',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
