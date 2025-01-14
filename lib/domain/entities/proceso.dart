import 'package:isar/isar.dart';
part 'proceso.g.dart';




@collection
class Proceso {
  Id? isarId;
  final String ntroquel;
  

  final DateTime fechaIngreso;
  final DateTime fechaEstimada;
  final String planta;
  final String cliente;
  final String maquina;
  final String ingeniero;
  final String observaciones;
  @enumerated
  late final Estado estado;
  

  Proceso( 
      {required this.ntroquel,
      required this.fechaIngreso,
      required this.fechaEstimada,
      required this.planta,
      required this.cliente,
      required this.maquina,
      required this.ingeniero,
      required this.observaciones,
      required this.estado});
}

enum Estado { suspendido, enProceso, completado, pendiente }
