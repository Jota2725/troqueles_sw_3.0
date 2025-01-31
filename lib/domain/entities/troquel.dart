import 'package:isar/isar.dart';
part 'troquel.g.dart';

@collection
class Troquel {
  Id? isarId;
  final String? nota;
  final String? ubicacion;
  final int gico;
  final String referencia;
  final String cliente;
  final String? no_cad;
  final String maquina;
  final String? clave;
  final String? alto;
  final String? largo;
  final String? ancho;
  final String? cabida;
  final String? estilo;
  final String? descripcion;
  final String? sector;

  Troquel(
      {this.nota,
      this.ubicacion,
      required this.gico,
      required this.referencia,
      required this.cliente,
      this.no_cad,
      required this.maquina,
      this.alto,
      this.clave,
      this.largo,
      this.ancho,
      this.cabida,
      this.estilo,
      this.descripcion,
      this.sector});
}
