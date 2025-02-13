import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';

import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/proceso.dart';
import '../../domain/entities/tiempos.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  late String installDir;
  late String lockfile;

  IsarDatasource() {
    installDir = getInstallDir();
    lockfile = '$installDir/app.lock';
    db = openDB();
  }

  Future<Isar> openDB() async {
    

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          TroquelSchema,
          ProcesoSchema,
          ConsumoSchema,
          MaterialesSchema,
          OperarioSchema,
          TiemposSchema
        ],
        directory: installDir,
        inspector: true,
        // Permitir lectura en modo seguro
      );
    }
    return Future.value(Isar.getInstance());
  }

  String getInstallDir() {
    final installDir = Directory.current.path;
    return installDir;
  }

  Future<bool> isAppInUse() async {
    final lockfilep = File(lockfile);
    return await lockfilep.exists();
  }

  Future<void> createLockfile() async {
    final lockfilep = File(lockfile);
    await lockfilep.writeAsString('locked', mode: FileMode.writeOnly);
  }

  Future<void> deleteLockfile() async {
    final lockfilep = File(lockfile);
    if (await lockfilep.exists()) {
      await lockfilep.delete();
    }
  }

  Future<void> closeDB() async {
    await deleteLockfile();
  }

  Future<void> ensureNoOtherInstance() async {
    final lockFilep = File(lockfile);
    if (await lockFilep.exists()) {
      throw Exception('La base de datos está en uso en otro computador.');
    }
  }

  // -----------------------------------------CRUD DE TROQUELES ----------------------------------------------

  // GUARDAR TROQUEL
  @override
  Future<void> saveTroqueles(List<Troquel> troqueles) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.putAll(troqueles);
    });
    await deleteLockfile();
  }

  //OBTENER TODOS LOS TROQUELES
  @override
  Future<List<Troquel>> getAllTroqueles() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    final troqueles = await isar.troquels.where().findAll();
    await deleteLockfile();
    return troqueles;
  }

  // ELIMINAR TODOS LOS TROQUELES
  @override
  Future<void> deleteAllTroqueles() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.clear();
    });
    await deleteLockfile();
  }

  // BORRAR TROQUEL
  @override
  Future<void> deleteTroquel(int id) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.delete(id);
    });
    await deleteLockfile();
  }

  // OBTENER TROQUEL POR ID
  @override
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();

    final isar = await db;
    final troquel = await isar.troquels
        .filter()
        .gicoEqualTo(gico)
        .and()
        .maquinaEqualTo(maquina)
        .findFirst();

    await deleteLockfile();
    return troquel;
  }

  //ACTUALIZAR TROQUEL
  @override
  Future<void> updateTroquel(Troquel troquel) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      final updatedTroquel = Troquel(
        nota: troquel.nota,
        ubicacion: troquel.ubicacion,
        gico: troquel.gico,
        cliente: troquel.cliente,
        no_cad: troquel.no_cad,
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
    await deleteLockfile();
  }

  @override
  Future<void> deleteAllTroquelesbyMachine(String maquina) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.filter().maquinaEqualTo(maquina).deleteAll();
    });
    await deleteLockfile();
  }

  @override
  Future<List<Troquel>> getAllTroquelesPorMaquina(String maquina) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    final troqueles =
        await isar.troquels.filter().maquinaEqualTo(maquina).findAll();
    await deleteLockfile();
    return troqueles;
  }

  @override
  Future<List<Troquel>> getTroquelesLibres(String maquina) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    final query = isar.troquels
        .where()
        .filter()
        .ubicacionEqualTo('')
        .or()
        .ubicacionIsNull()
        .and()
        .maquinaEqualTo(maquina);
    final troqueles = await query.findAll();
    await deleteLockfile();
    return troqueles;
  }

//-------------------------------------------------------Troqueles en proceso------------------------------------------------------------------------------------------------------
  @override
  Future<List<Proceso>> getAllTroquelesInProcess() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;

   final procesos = await isar.procesos.where().findAll();

    await deleteLockfile();

    return  procesos;
  }


  Future<List<Proceso>> getTroquelesByEstado(Estado estado) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    final procesos =
        await isar.procesos.where().filter().estadoEqualTo(estado).findAll();
        await deleteLockfile();
    return procesos;
  }

  Future<Proceso?> getTroquelInProcess(String troquel) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    final proceso = await isar.procesos.filter().ntroquelEqualTo(troquel).findFirst();
    await deleteLockfile();
    return proceso;
  }

  @override
  Future<void> addNewTroquelInProcess(List<Proceso> proceso) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.putAll(proceso);
    });
    await deleteLockfile();
  }

  @override
  Future<void> deleteTroquelInProcees(int id) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.delete(id);
    });
    await deleteLockfile();
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

  @override
  Future<List<Consumo>> getAllConsumos() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    return await isar.consumos.where().findAll();
  }

  //----------------------MATERIALES---------------------------------------
  @override
  Future<List<Materiales>> gettAllMateriles() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    return await isar.materiales.where().findAll();
  }

  Future<void> addNewMaterial(List<Materiales> materiales) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.materiales.putAll(materiales);
    });
  }

  Future<void> addNewConsumo(List<Consumo> consumos) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.consumos.putAll(consumos);

      for (var i = 0; i < consumos.length; i++) {
        final consumo = consumos[i];
        // Asegúrate de que los materiales estén asociados al consumo correcto
        consumo.materiales.save();
      }
    });
  }

  Future<List<Tiempos>> getAllTiempos() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    return await isar.tiempos.where().findAll();
  }

  Future<void> addNewTiempo(List<Tiempos> tiempos) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tiempos.putAll(tiempos);
    });
  }

  Future<List<Operario>> getAllOperarios() async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    return await isar.operarios.where().findAll();
  }

  Future<void> addNewOperarios(List<Operario> operarios) async {
    await ensureNoOtherInstance(); // Verificar que no haya otra instancia
    await createLockfile();
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.operarios.putAll(operarios);
    });
  }
}
