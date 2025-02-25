import 'package:isar/isar.dart';

import 'materiales.dart';

part 'consumo.g.dart';

@collection
class Consumo {
  Id? isarid;
  final String planta;
  final String nTroquel;
  final String cliente;
  @Backlink(to: 'consumo') // Relación inversa hacia la entidad Materiales.
  final IsarLinks<Materiales> materiales = IsarLinks<Materiales>();
  final String tipo;
  final int cantidad;

  Consumo(
      {required this.nTroquel,
      required this.planta,
      required this.cliente,
      required this.tipo,
      required this.cantidad});
}
