import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<void> saveTroqueles(List<Troquel> troqueles) {
    return datasource.saveTroqueles(troqueles);
  }

  @override
  Future<void> deleteAllTroqueles() {
    return datasource.deleteAllTroqueles();
  }

  @override
  Future<void> deleteTroquel(int id) {
    return datasource.deleteTroquel(id);
  }

  @override
  Future<List<Troquel>> getAllTroqueles() {
    return datasource.getAllTroqueles();
  }

  @override
  Future<void> updateTroquel(Troquel troquel) {
    return datasource.updateTroquel(troquel);
  }

  @override
  Future<void> deleteAllTroquelesbyMachine(String maquina) {
    return datasource.deleteAllTroquelesbyMachine(maquina);
  }

  @override
  Future<void> getAllTroquelesPorMaquina(String maquina) {
    return datasource.getAllTroquelesPorMaquina(maquina);
  }

  @override
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina) {
    return datasource.getTroquelByGicoAndMaquina(gico, maquina);
  }

  @override
  Future<void> getTroquelesLibres(String maquina) {
    return datasource.getTroquelesLibres(maquina);
  }

  @override
  Future<void> addNewTroquelInProcess(List<Proceso> proceso) {
    return datasource.addNewTroquelInProcess(proceso);
  }

  @override
  Future<void> deleteTroquelInProcees(int id) {
    return datasource.deleteTroquelInProcees(id);
  }

  @override
  Future<List<Proceso>> getAllTroquelesInProcess() {
    return datasource.getAllTroquelesInProcess();
  }

  @override
  Future<void> updatedTroquelInProcess(Proceso proceso) {
    return datasource.updatedTroquelInProcess(proceso);
  }
}
