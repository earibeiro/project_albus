import 'package:flutter_test/flutter_test.dart';
import 'package:albus/app/database/sqlite/connection.dart';
import 'package:albus/app/database/script.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  late Database db;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    db = await Connection.open();
  });

  group('Testes de conexão', () {
    test('apagar tabela teacher se existir', () async {
      try {
        await db.execute('DROP TABLE IF EXISTS teacher');
      } catch (e) {
        throw Exception('Erro ao tentar apagar a tabela teacher: $e');
      }
    });

    test('recriar tabela teacher', () async {
      try {
        for (var script in createTables) {
          await db.execute(script);
        }
        for (var script in insertRecords) {
          await db.execute(script);
        }
      } catch (e) {
        throw Exception('Erro ao tentar recriar a tabela teacher: $e');
      }
    });

    test('teste script create table', () async {
      var list = await db.rawQuery('SELECT * FROM teacher');
      expect(list.length, 3);
    });

    test('teste de inserção', () async {
      await db.insert('teacher', {
        'id': 4,
        'name': 'Professor Teste',
        'email': 'professor@teste.com',
        'cpf': '12345678901',
      });

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 4');
      expect(list.length, 1);
      expect(list.first['name'], 'Professor Teste');
      expect(list.first['email'], 'professor@teste.com');
      expect(list.first['cpf'], '12345678901');
    });

    test('teste de atualização', () async {
      await db.update(
        'teacher',
        {'name': 'Professor Atualizado'},
        where: 'id = ?',
        whereArgs: [4],
      );

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 4');
      expect(list.length, 1);
      expect(list.first['name'], 'Professor Atualizado');
    });

    test('teste de exclusão', () async {
      await db.delete('teacher', where: 'id = ?', whereArgs: [4]);

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 4');
      expect(list.length, 0);
    });
  });
}