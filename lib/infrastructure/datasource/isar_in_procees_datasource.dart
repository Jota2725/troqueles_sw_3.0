import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troqueles_sw/domain/datasource/troquel_en_proceso_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

class IsarInProceesDatasource extends TroquelEnProcesoDatasource {
  late Future<Isar> db;

  IsarInProceesDatasource() {
    db = openDB();
  }

  // ABRIR BASE DE DATOS
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ProcesoSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
  

  @override
  Future<void> addNewTroquel(List<Proceso> proceso) {
    // TODO: implement addNewTroquel
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTroquelInProcees(int id) {
    // TODO: implement deleteTroquelInProcees
    throw UnimplementedError();
  }

  @override
  Future<List<Proceso>> getAllTroquelesInProcess() {
    // TODO: implement getAllTroquelesInProcess
    throw UnimplementedError();
  }

  @override
  Future<void> updateTroquelInProcces(Proceso proceso) {
    // TODO: implement updateTroquelInProcces
    throw UnimplementedError();
  }
}
