import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

import '../entities/consumo.dart';
import '../entities/materiales.dart';

abstract class LocalStorageDatasource {

  // TODO TROQUELES BIBILIACO
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

  // TODO CONSUMOS DE MATERIALES

  Future<List<Consumo>>getAllConsumos();

  
  Future<List<Materiales>>gettAllMateriles(); 

  
  
}
