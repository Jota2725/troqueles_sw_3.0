import 'package:isar/isar.dart';
import 'materiales.dart';

part 'consumo.g.dart';

@collection
class Consumo {
  Id? isarid;

  final String planta;
  final String nTroquel;
  final String cliente;
  final String tipo;
  final int cantidad;

  final IsarLinks<Materiales> materiales;

  Consumo({
    required this.nTroquel,
    required this.planta,
    required this.cliente,
    required this.tipo,
    required this.cantidad,
    IsarLinks<Materiales>? materiales,
  }) : materiales = materiales ?? IsarLinks<Materiales>();
}
