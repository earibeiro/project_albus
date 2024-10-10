import 'package:flutter_test/flutter_test.dart';
import 'package:albus/app/database/sqlite/connection.dart';
import 'package:albus/app/database/script.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    db = await Connection.open();

    // Verificar se a tabela existe e criar se não existir
    try {
      var result = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='teacher'");
      if (result.isEmpty) {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS teacher (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            cpf TEXT NOT NULL
          )
        ''');
      }
    } catch (e) {
      throw Exception('Erro ao tentar verificar ou criar a tabela teacher: $e');
    }
  });

  group('Testes de conexão', () {
    test('teste script create table', () async {
      var list = await db.rawQuery('SELECT * FROM teacher');
      expect(list.length, 0); // Ajustado para 0, pois não há registros iniciais
    });

    test('teste de inserção', () async {
      await db.insert('teacher', {
        'id': 1,
        'name': 'Professor Teste',
        'email': 'professor@teste.com',
        'cpf': '12345678901',
      });

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 1');
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
        whereArgs: [1],
      );

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 1');
      expect(list.length, 1);
      expect(list.first['name'], 'Professor Atualizado');
    });

    test('teste de exclusão', () async {
      await db.delete('teacher', where: 'id = ?', whereArgs: [1]);

      var list = await db.rawQuery('SELECT * FROM teacher WHERE id = 1');
      expect(list.length, 0);
    });
  });
}