

import '../entities/proceso.dart';
import '../entities/troquel.dart';

abstract class LocalStorageRepository{
Future<void> saveTroqueles(List<Troquel> troqueles);
  Future<List<Troquel>> getAllTroqueles();
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina );
  Future<void> updateTroquel(Troquel troquel);
  Future<void> deleteTroquel(int id);
  Future<void> deleteAllTroqueles();
  Future<void>deleteAllTroquelesbyMachine(String maquina);
  Future<void>getAllTroquelesPorMaquina(String maquina);
  Future<void>getTroquelesLibres(String maquina);

  // TODO TROQUELES EN PROCESO

  Future<List<Proceso>>getAllTroquelesInProcess();
  Future<void>addNewTroquelInProcess(List<Proceso> proceso);
  Future<void>deleteTroquelInProcees(int id);
  Future<void>updatedTroquelInProcess(Proceso proceso);


}