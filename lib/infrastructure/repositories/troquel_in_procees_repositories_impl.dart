
import 'package:troqueles_sw/domain/datasource/troquel_en_proceso_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

import '../../domain/repositories/troquel_in_process_repositories.dart';

class TroquelInProceesRepositoriesImpl extends TroquelInProcessRepositories {

  final TroquelEnProcesoDatasource datasource;

  TroquelInProceesRepositoriesImpl( this.datasource);



  @override
  Future<void> addNewTroquel(List<Proceso> proceso) {
     return  datasource.addNewTroquel(proceso);
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
  Future<void> updateTroquelInProcces(Proceso proceso) {
    return datasource.updateTroquelInProcces(proceso);
  }


  
}