import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/app/database/sqlite/connection.dart';

class DaoStudent implements IDAOStudent {
  late Database _db;

  @override
  Future<DTOStudent> save(DTOStudent dto) async {
    _db = await Connection.open();
    int id = await _db.rawInsert(
      '''INSERT INTO student(name, email, phone, cpf, password) 
      VALUES (?, ?, ?, ?, ?)''', [dto.name, dto.email, dto.phone, dto.cpf, dto.password]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(dynamic id) async {
    final db = await Connection.open();
    await db.delete('student', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<DTOStudent> update(DTOStudent dto) async {
    final db = await Connection.open();
    await db.update(
      'student',
      dto.toMap(),
      where: 'id = ?',
      whereArgs: [dto.id],
    );
    return dto;
  }

  @override
  Future<DTOStudent> read(dynamic id) async {
    final db = await Connection.open();
    final maps = await db.query(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DTOStudent.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<List<DTOStudent>> list() async {
    final db = await Connection.open();
    final List<Map<String, dynamic>> maps = await db.query('student');

    return List.generate(maps.length, (i) {
      return DTOStudent.fromMap(maps[i]);
    });
  }
}