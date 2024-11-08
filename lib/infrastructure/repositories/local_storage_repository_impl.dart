import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl( this.datasource);

  
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
  Future<Troquel?> getTroquelById(int id) {
    return datasource.getTroquelById(id);
  }
  
  @override
  Future<void> updateTroquel(Troquel troquel) {
    return datasource.updateTroquel(troquel);
  }
  
  @override
  Future<void> deleteAllTroquelesbyMachine(String maquina) {
    return deleteAllTroquelesbyMachine(maquina);
  }
  
}