import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'aniversaris.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE aniversaris(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, dataNaixement DATETIME)');
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
    print('inserted ==>table=$table data=$data ');
    return id;
  }

  static Future<void> remove(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = "$id"');
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
