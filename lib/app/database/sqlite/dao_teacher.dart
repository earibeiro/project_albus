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
      '''INSERT INTO teacher(name, description, email, phone, cpf, photo) 
      VALUES (?, ?, ?, ?, ?, ?)''', [dto.name, dto.description, dto.email, dto.phone, dto.cpf, dto.photo]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(DTOTeacher dto) async {
    final db = await Connection.open();
    await db.delete('teacher', where: 'id = ?', whereArgs: [dto.id]);
  }
}




