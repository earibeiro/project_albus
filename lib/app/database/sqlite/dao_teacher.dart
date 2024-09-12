import 'package:albus/dominio/interface/dao_teacher.dart';
import 'package:albus/domain/dto/dto_teacher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/database/sqlite/connection.dart';

class DaoTeacher implements IDAOTeacher {
  @override
  Future<DTOTeacher> save(DTOTeacher dto) async {
    final db = await Connection.open();
    if (dto.id == null) {
      dto.id = await db.insert('teacher', dto.toMap());
    } else {
      await db.update('teacher', dto.toMap(), where: 'id = ?', whereArgs: [dto.id]);
    }
    return dto;
  }

  @override
  Future<void> remove(DTOTeacher dto) async {
    final db = await Connection.open();
    await db.delete('teacher', where: 'id = ?', whereArgs: [dto.id]);
  }
}