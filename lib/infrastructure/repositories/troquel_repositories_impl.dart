import 'dart:io';

import 'package:troqueles_sw/domain/datasource/troquel_datasource.dart';
import 'package:troqueles_sw/domain/entities/troqueles.dart';
import 'package:troqueles_sw/domain/repositories/troquel_repositories.dart';

class TroquelRepositoriesImpl extends TroquelRepositories {

  final TroquelDatasource datasource;
  TroquelRepositoriesImpl(this.datasource);

  @override
  Future<List<Troquel>> importarTroquelesDesdeExcel(File file, String  sheetName ) {
    return datasource.importarTroquelesDesdeExcel(file,sheetName);
  }

  @override
  Future<List<Troquel>> seleccionarArchivoExcel(String sheetName) {
    return datasource.seleccionarArchivoExcel(sheetName);
  }
}