import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([TroquelSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  
  @override
  Future<void> saveTroqueles(List<Troquel> troqueles)async {
     final isar = await db;
    await isar.writeTxn(()async{

      await isar.troquels.putAll(troqueles);
    });
  }
 Future<List<Troquel>> getAllTroqueles() async {
    final isar = await db;
    return await isar.troquels.where().findAll(); // Obtiene todos los registros de Troquel
  }

}
