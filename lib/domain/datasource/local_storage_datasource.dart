import 'package:troqueles_sw/domain/entities/troquel.dart';

abstract class LocalStorageDatasource {
  Future<void> saveTroqueles(List<Troquel> troqueles);
  Future<List<Troquel>> getAllTroqueles();
  Future<Troquel?> getTroquelById(int id);
  Future<void> updateTroquel(Troquel troquel);
  Future<void> deleteTroquel(int id);
  Future<void> deleteAllTroqueles();
  Future<void>deleteAllTroquelesbyMachine(String maquina);
  
}
