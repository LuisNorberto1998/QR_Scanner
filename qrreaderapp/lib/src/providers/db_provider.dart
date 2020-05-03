import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  //Constructor Privdado
  DBProvider._();

  Future<Database> get database async {
    if (database != null) return _database;
    _database = await initDB();
    return _database;
  }

  //Instancia de base de datos
  initDB() async {

  }
}
