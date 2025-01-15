// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
part 'materiales.g.dart';

@collection
class Materiales {
  Id? isarId;
  final int codigo;
  @enumerated
  final Unidad unidad;
  final String descripcion;
  @enumerated
  final Tipo tipo;

  final int cantidad;
  final double conversion;
  final IsarLink<Consumo> consumo =
      IsarLink<Consumo>(); // Relación hacia Consumo.

  Materiales(
      {required this.codigo,
      required this.unidad,
      required this.descripcion,
      required this.tipo,
      required this.cantidad,
      required this.conversion});
}

enum Unidad<String> {
  mts,
  par,
  plancha,
  rollo,
  und,
  cm,
  caja,
  cm2,
  doc,
  kit,
  bolsa,
  tiras,
  tiras_plan,
}

enum Tipo { maderas, cuchillas, escores, gomas, herramientas, prealistamientos }
