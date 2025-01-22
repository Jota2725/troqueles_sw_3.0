
import 'package:isar/isar.dart';
part 'operario.g.dart';
@collection
class Operario {
  Id? isarId;
  final int ficha;
  final String nombre;

  Operario({required this.ficha, required this.nombre});
}
