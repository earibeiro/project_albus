
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
  void remove(DTOStudent dto) async {
    _db = await Connection.open();
    int id = await _db.rawDelete(
      '''DELETE FROM student WHERE id = ?''', [dto.id]);
    dto.id = id;
  }

  @override
  Future<DTOStudent> update(DTOStudent dto) async {
    _db = await Connection.open();
    int id = await _db.rawUpdate(
      '''UPDATE student SET name = ?, password = ?, email = ?, phone = ?, cpf = ? WHERE id = ?''', 
      [dto.name, dto.password, dto.email, dto.phone, dto.cpf, dto.id]);
    dto.id = id;
    return dto;
  }

  @override
  Future<DTOStudent> read(DTOStudent dto) async {
    _db = await Connection.open();
    List<Map<String, dynamic>> maps = await _db.rawQuery('SELECT * FROM students WHERE id = ?', [dto.id]);

    if (maps.isNotEmpty) {
      return DTOStudent.fromJson(maps.first);
    } else {
      throw Exception('Student not found');
    }
  }

  @override
  Future<List<DTOStudent>> list() async {
    _db = await Connection.open();
    List<Map<String, dynamic>> maps = await _db.rawQuery('SELECT * FROM students');
    
    return List.generate(maps.length, (i) {
      return DTOStudent.fromJson(maps[i]);
    });
  }
}