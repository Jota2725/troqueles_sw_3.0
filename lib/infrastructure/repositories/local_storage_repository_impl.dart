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
  
}