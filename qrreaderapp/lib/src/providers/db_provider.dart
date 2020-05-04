import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
//Export expone el modelo a quien importe DBProvider
export 'package:qrreaderapp/src/models/scan_model.dart';
//Importación de path (join)
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  //Constructor Privdado
  DBProvider._();

  //Obtener bdb
  Future<Database> get database async {
    //Si es nula
    if (_database != null) return _database;
    //Se crea una nueva base de datos
    _database = await initDB();
    return _database;
  }

  //Instancia de base de datos
  initDB() async {
    //Documento donde puedes escribir
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Unir documentsDirectory y nombre del archivo de la db (el que usa SQLite).
    final path = join(documentsDirectory.path, 'ScansDB.db');

    //Comandos para crear DB en SQLite

    return await openDatabase(path, //ruta-dirección
        version: 1, //
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      //Inicialización de la db
      await db.execute(
          'CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')');
    });
  }

  /*Crear registros en la bd*/
  //Primer ejemplo de inserccion de registros
  nuevoScanRow(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert(
        //Se deja un espacio entre Values y el parentesis para evitar error de sintaxis
        "INSERT Into Scans(id,tipo,valor) "
        "VALUES (${nuevoScan.id},'${nuevoScan.tipo}','${nuevoScan.valor}')");

    return res;
  }

  //Segundo ejemplo de inserccion de registros
  nuevoScan(ScanModel nuevoScan) async {
    //Se necesita la instacia de la db
    final db = await database;

    //Inserccion de los valores
    final res = await db.insert('Scans', nuevoScan.toJson());
    //toJson transforma el modelo y regresa un mapa que tiene String dynamic que se puede enviar hacia el insert
    //Se regresa el resultado.
    return res;
  }

  /*SELECT - Obtener información*/
  //Scans por ID
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    //Consulta de registros hacia la tabla
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    //Returna un Scan por ID
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  //Regresa todos los Scans
  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  //Scans que cumplan la condición del tipo
  Future<List<ScanModel>> getScansTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");
    //Se recibe un Listado de Map de String dynamic pasando por el Map
    //Creando instancias del ScanModel del fromJson
    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  /*ACTUALIZAR REGISTROS */
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id=?', whereArgs: [nuevoScan.id]);
    return res;
  }

  /*BORRAR REGISTROS */
  //Borrar registro por id
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

//Borrar todos los registros
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }
}
