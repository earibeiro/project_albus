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
      '''INSERT INTO teacher(name, description, email, phone, cpf, password) 
      VALUES (?, ?, ?, ?, ?, ?)''', [dto.name, dto.description, dto.email, dto.phone, dto.cpf, dto.password]);
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
      {
        'name': dto.name,
        'description': dto.description,
        'email': dto.email,
        'phone': dto.phone,
        'cpf': dto.cpf,
        'password': dto.password,
      },
      where: 'id = ?',
      whereArgs: [dto.id],
    );
    return dto;
  }

  @override
  Future<DTOTeacher> read(dynamic id) async {
    final db = await Connection.open();
    List<Map<String, dynamic>> result = await db.query('teacher', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return DTOTeacher(
        id: result.first['id'],
        name: result.first['name'],
        description: result.first['description'],
        email: result.first['email'],
        phone: result.first['phone'],
        cpf: result.first['cpf'],
        password: result.first['password'],
      );
    } else {
      throw Exception('Teacher not found');
    }
  }

  @override
  Future<List<DTOTeacher>> list() async {
    final db = await Connection.open();
    List<Map<String, dynamic>> result = await db.query('teacher');
    return result.map((data) => DTOTeacher(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      email: data['email'],
      phone: data['phone'],
      cpf: data['cpf'],
      password: data['password'],
    )).toList();
  }
}