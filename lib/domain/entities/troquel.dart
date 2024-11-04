
import 'package:isar/isar.dart';
part 'troquel.g.dart';

@collection
class Troquel {

  Id? isarId;
  final int ubicacion;
  //GICO ES ID
  final int gico;
  final String cliente;
  final int referencia;
  final String maquina;
  final String? clave;
  final int? largo;
  final int? ancho;
  final int? alto;
  final int? cabida;
  final String? estilo;
  final String? descripcion;


 Troquel({
  required this.ubicacion,
  required this.gico, 
  required this.cliente, 
  required this.referencia,
   required this.maquina, 
   this.clave, 
   this.largo, 
   this.ancho, 
   this.alto, 
   this.cabida, 
   this.estilo, 
   this.descripcion, 

 });
}
