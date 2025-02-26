import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

import '../entities/consumo.dart';
import '../entities/materiales.dart';

abstract class LocalStorageDatasource {
  //TROQUELES BIBILIACO
  Future<void> saveTroqueles(List<Troquel> troqueles); // Guardar troqueles
  Future<List<Troquel>> getAllTroqueles(); //Obtener todos los troqueles
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina); // Obtener troqueles por maquina 
  Future<void> updateTroquel(Troquel troquel); // Actualizar troquel
  Future<void> deleteTroquel(int id); // Borrar troquel
  Future<void> deleteAllTroqueles(); // Borrar  todos los troqueles
  Future<void> deleteAllTroquelesbyMachine(String maquina); // Borrar todos los troqueles por maquina
  Future<void> getAllTroquelesPorMaquina(String maquina); // Obtener troqueles por maquina  
  Future<void> getTroquelesLibres(String maquina); // Obtener troqueles libres
  // TROQUELES EN PROCESO
  Future<List<Proceso>> getAllTroquelesInProcess();
  Future<void> addNewTroquelInProcess(List<Proceso> proceso);
  Future<void> deleteTroquelInProcees(int id);
  Future<void> updatedTroquelInProcess(Proceso proceso);
  // CONSUMOS DE MATERIALES
  Future<List<Consumo>> getAllConsumos();
  Future<List<Materiales>> gettAllMateriles();
}
