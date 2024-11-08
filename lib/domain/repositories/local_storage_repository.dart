

import '../entities/troquel.dart';

abstract class LocalStorageRepository{
Future<void> saveTroqueles(List<Troquel> troqueles);
  Future<List<Troquel>> getAllTroqueles();
  Future<Troquel?> getTroquelById(int id);
  Future<void> updateTroquel(Troquel troquel);
  Future<void> deleteTroquel(int id);
  Future<void> deleteAllTroqueles();
  Future<void>deleteAllTroquelesbyMachine(String maquina);




}