import 'package:albus/app/database/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Connection {
  static late Database _db;
  static bool _isConnectionCreated = false;

  static Future<Database> open() async {
    if (!_isConnectionCreated) {
      var path = join(await getDatabasesPath(), 'database.db');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          for (var script in createTables) {
            await db.execute(script);
          }
          for (var script in insertRecords) {
            await db.execute(script);
          }
        },
      );
      _isConnectionCreated = true;
    }
    return _db;
  }
}