import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final tableName = 'userData';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, "user.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);

    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("Create table $tableName ("
        "id INTEGER PRIMARY KEY"
        "name TEXT"
        "phone TEXT"
        "token TEXT"
        ")");
  }
}
