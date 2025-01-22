// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';
import 'package:troqueles_sw/domain/entities/operario.dart';
part 'tiempos.g.dart';

@collection
class Tiempos {
  Id? isarId;
  final DateTime fecha;
  final String ntroquel;
  final IsarLinks<Operario> operario = IsarLinks<Operario>();
  final DateTime tiempo;
  @enumerated
  final Actividad actividad;

  Tiempos(
      {required this.fecha,
      required this.ntroquel,
      required this.tiempo,
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
