import 'package:albus/app/database/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Connection {
  static Database? _db;

  static Future<Database> open() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'database.db');
      print('Database path: $path');

      await deleteDatabase(path);

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          for (String table in createTables) {
            print('Executing: $table');
            await db.execute(table);
          }
        },
      );

      bool tableExists = await _tableExists('student');
      if (tableExists) {
        print('Tabela student criada com sucesso.');
      } else {
        print('Falha ao criar a tabela student.');
      }
    }
    return _db!;
  }

  static Future<bool> _tableExists(String tableName) async {
    var result = await _db!.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName]
    );
    print('Table exists result: $result');
    return result.isNotEmpty;
  }
}