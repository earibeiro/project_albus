
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/app/database/sqlite/connection.dart';

class DaoStudent implements  IDAOStudent {
  late Database _db;
  @override
  Future<DTOStudent> save(DTOStudent dto) async {
    _db = await Connection.open();
    int id = await _db.rawInsert(
      '''INSERT INTO student(name, password, email, phone, cpf) 
      VALUES (?, ?, ?, ?, ?)''', [dto.name, dto.password, dto.email, dto.phone, dto.cpf]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(DTOStudent dto) async {
    final db = await Connection.open();
    await db.delete('student', where: 'id = ?', whereArgs: [dto.id]);
  }
}