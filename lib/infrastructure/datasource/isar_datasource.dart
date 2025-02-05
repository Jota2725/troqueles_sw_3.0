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
  static Completer<Isar>? _dbCompleter;
  late String installDir;

  IsarDatasource() {
    installDir = getInstallDir();
  }

  Future<Isar> get db async {
    if (_dbCompleter == null) {
      _dbCompleter = Completer();
      _dbCompleter!.complete(_openDB());
    }
    return _dbCompleter!.future;
  }

  String getInstallDir() {
    try {
      final installDir = Directory.current.path;
      final configFile = File('$installDir\config.ini');
      if (configFile.existsSync()) {
        final lines = configFile.readAsLinesSync();
        for (var line in lines) {
          if (line.startsWith("InstallDir=")) {
            return line.split("=")[1];
          }
        }
      }
      return installDir;
    } catch (e) {
      print(
          "⚠️ No se pudo leer el directorio de instalación, usando la predeterminada.");
    }
    return '';
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isNotEmpty) {
      return Future.value(Isar.getInstance());
    }
    return await Isar.open(
      [
        TroquelSchema,
        ProcesoSchema,
        ConsumoSchema,
        MaterialesSchema,
        OperarioSchema,
        TiemposSchema
      ],
      inspector: true,
      directory: installDir,
    );
  }

  Future<void> closeDatabase() async {
    final isar = await db;
    await isar.close();
    _dbCompleter = null;
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

  Future<List<Proceso>> getTroquelesByEstado(Estado estado) async {
    final isar = await db;
    final procesos =
        await isar.procesos.where().filter().estadoEqualTo(estado).findAll();
    return procesos;
  }

  Future<Proceso?> getTroquelInProcess(String troquel) async {
    final isar = await db;
    return await isar.procesos.filter().ntroquelEqualTo(troquel).findFirst();
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

  @override
  Future<List<Consumo>> getAllConsumos() async {
    final isar = await db;
    return await isar.consumos.where().findAll();
  }

  //----------------------MATERIALES---------------------------------------
  @override
  Future<List<Materiales>> gettAllMateriles() async {
    final isar = await db;
    return await isar.materiales.where().findAll();
  }

  Future<void> addNewMaterial(List<Materiales> materiales) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.materiales.putAll(materiales);
    });
  }

  Future<void> addNewConsumo(List<Consumo> consumos) async {
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
    final isar = await db;
    return await isar.tiempos.where().findAll();
  }

  Future<void> addNewTiempo(List<Tiempos> tiempos) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tiempos.putAll(tiempos);
    });
  }

  Future<List<Operario>> getAllOperarios() async {
    final isar = await db;
    return await isar.operarios.where().findAll();
  }

  Future<void> addNewOperarios(List<Operario> operarios) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.operarios.putAll(operarios);
    });
  }
}
