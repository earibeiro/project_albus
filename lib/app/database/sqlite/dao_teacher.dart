import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/app/database/sqlite/connection.dart';

class DaoTeacher implements IDAOTeacher {
  late Database _db;

  @override
  Future<DTOTeacher> save(DTOTeacher dto) async {
    _db = await Connection.open();
    int id = await _db.rawInsert(
      '''INSERT INTO teacher(name, email, phone, cpf, password) 
      VALUES (?, ?, ?, ?, ?)''', [dto.name, dto.email, dto.phone, dto.cpf, dto.password]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(dynamic id) async {
    final db = await Connection.open();
    await db.delete('teacher', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<DTOTeacher> update(DTOTeacher dto) async {
    final db = await Connection.open();
    await db.update(
      'teacher',
      dto.toMap(),
      where: 'id = ?',
      whereArgs: [dto.id],
    );
    return dto;
  }

  @override
  Future<DTOTeacher> read(dynamic id) async {
    final db = await Connection.open();
    final maps = await db.query(
      'teacher',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DTOTeacher.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<List<DTOTeacher>> list() async {
    final db = await Connection.open();
    final List<Map<String, dynamic>> maps = await db.query('teacher');

    return List.generate(maps.length, (i) {
      return DTOTeacher.fromMap(maps[i]);
    });
  }
}