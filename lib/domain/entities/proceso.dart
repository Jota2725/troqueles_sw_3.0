import 'troquel.dart';

class Proceso {
  final Troquel troquel;
  final DateTime fechaIngreso;
  final DateTime fechaEstimada;
  final String planta;
  final String cliente;
  final String maquina;
  final String ingeniero;
  final String observaciones;
  final Estado estado;

  Proceso(
      {required this.troquel,
      required this.fechaIngreso,
      required this.fechaEstimada,
      required this.planta,
      required this.cliente,
      required this.maquina,
      required this.ingeniero,
      required this.observaciones,
      required this.estado});
}

enum Estado { suspendido, enProceso, completado }
