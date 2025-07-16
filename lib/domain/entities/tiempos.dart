// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

part 'tiempos.g.dart';

@collection
class Tiempos {
  Id? isarId;
  final String fecha;
  final String ntroquel;
  final String? operarios;
  final String? ficha;
  final double tiempo;
  @enumerated
  final Actividad actividad;

  Tiempos(
      {required this.fecha,
      required this.ntroquel,
      required this.tiempo,
      this.operarios,
      this.ficha,
      required this.actividad});
}

enum Actividad {
  Dibujo,
  Encuchillado,
  Punteado,
  Calado,
  Serrapid,
  Engomado,
  Prueba,
  Empaque
}
