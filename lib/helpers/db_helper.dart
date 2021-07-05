import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'aniversaris.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE aniversaris(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, cognom1 TEXT, cognom2 TEXT, dataNaixement DATETIME)');
      },
      version: 1,
    );
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    final id = await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<void> update(
      String table, Map<String, Object> data, int _id) async {
    final db = await DBHelper.database();
    await db.update(table, data, where: 'id = ?', whereArgs: [_id]);
  }

  static Future<void> remove(String table, int id) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = "$id"');
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    print('get data');
    final db = await DBHelper.database();
    return db.query(table);
  }
}
