import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

import '../../domain/entities/proceso.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }
  // ABRIR BASE DE DATOS
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([TroquelSchema, ProcesoSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
  // -----------------------------------------CRUD DE TROQUELES ----------------------------------------------

  // GUARDAR TROQUEL
  @override
  Future<void> saveTroqueles(List<Troquel> troqueles) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.putAll(troqueles);
    });
  }

  //OBTENER TODOS LOS TROQUELES
  @override
  Future<List<Troquel>> getAllTroqueles() async {
    final isar = await db;
    return await isar.troquels.where().findAll();
  }

  // ELIMINAR TODOS LOS TROQUELES
  @override
  Future<void> deleteAllTroqueles() async {
    final isar = await db;
    return await isar.writeTxn(() async {
      await isar.troquels.clear();
    });
  }

  // BORRAR TROQUEL
  @override
  Future<void> deleteTroquel(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      await isar.troquels.delete(id);
    });
  }

  // OBTENER TROQUEL POR ID
  @override
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina) async {
    final isar = await db;
    return await isar.troquels
        .filter()
        .gicoEqualTo(gico)
        .and()
        .maquinaEqualTo(maquina)
        .findFirst();
  }

  //ACTUALIZAR TROQUEL
  @override
  Future<void> updateTroquel(Troquel troquel) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      final updatedTroquel = Troquel(
        ubicacion: troquel.ubicacion,
        gico: troquel.gico,
        cliente: troquel.cliente,
        referencia: troquel.referencia,
        maquina: troquel.maquina,
        clave: troquel.clave,
        largo: troquel.largo,
        ancho: troquel.ancho,
        alto: troquel.alto,
        cabida: troquel.cabida,
        estilo: troquel.estilo,
        descripcion: troquel.descripcion,
      )..isarId = troquel.isarId;

      await isar.troquels.put(updatedTroquel);
    });
  }

  @override
  Future<void> deleteAllTroquelesbyMachine(String maquina) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      await isar.troquels.filter().maquinaEqualTo(maquina).deleteAll();
    });
  }

  @override
  Future<List<Troquel>> getAllTroquelesPorMaquina(String maquina) async {
    final isar = await db;
    return await isar.troquels.filter().maquinaEqualTo(maquina).findAll();
  }

  @override
  Future<List<Troquel>> getTroquelesLibres(String maquina) async {
    final isar = await db;
    final query = isar.troquels
        .where()
        .filter()
        .ubicacionEqualTo('')
        .or()
        .ubicacionIsNull()
        .and()
        .maquinaEqualTo(maquina);
    return await query.findAll();
  }

//-------------------------------------------------------Troqueles en proceso------------------------------------------------------------------------------------------------------
  @override
  Future<List<Proceso>> getAllTroquelesInProcess() async {
    final isar = await db;
    return await isar.procesos.where().findAll();
  }


  
  Future<Proceso?> getTroquelInProcess(String troquel) async {
    final isar = await db;
    return await isar.procesos.filter().ntroquelEqualTo(troquel).findFirst() ;
  }


  @override
  Future<void> addNewTroquelInProcess(List<Proceso> proceso) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.putAll(proceso);
    });
  }

  @override
  Future<void> deleteTroquelInProcees(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.delete(id);
    });
  }

  @override
  Future<void> updatedTroquelInProcess(Proceso proceso) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      final updatedProceso = Proceso(
          ntroquel: proceso.ntroquel,
          fechaIngreso: proceso.fechaIngreso,
          fechaEstimada: proceso.fechaEstimada,
          planta: proceso.planta,
          cliente: proceso.cliente,
          maquina: proceso.maquina,
          ingeniero: proceso.ingeniero,
          observaciones: proceso.observaciones,
          estado: proceso.estado)
        ..isarId = proceso.isarId;

      await isar.procesos.put(updatedProceso);
    });
  }
}
