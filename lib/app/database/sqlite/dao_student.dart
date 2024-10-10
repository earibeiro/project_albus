import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/app/database/sqlite/connection.dart';

class DaoStudent implements IDAOStudent {
  late Database _db;

  @override
  Future<DTOStudent> save(DTOStudent dto) async {
    _db = await Connection.open();
    print('Inserting student: ${dto.name}, ${dto.password}, ${dto.email}, ${dto.phone}, ${dto.cpf}');
    int id = await _db.rawInsert(
      '''INSERT INTO student(name, password, email, phone, cpf) 
      VALUES (?, ?, ?, ?, ?)''', [dto.name, dto.password, dto.email, dto.phone, dto.cpf]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(dynamic id) async {
    _db = await Connection.open();
    await _db.rawDelete(
      '''DELETE FROM student WHERE id = ?''', [id]);
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
    return _db.rawQuery('SELECT * FROM student WHERE id = ?', [dto.id]).then((value) {
      return DTOStudent(
        id: value[0]['id'],
        name: value[0]['name'] as String,
        password: value[0]['password'] as String,
        email: value[0]['email'] as String,
        phone: value[0]['phone'] as String,
        cpf: value[0]['cpf'] as String
      );
    });
  }

  @override
  Future<List<DTOStudent>> list() async {
    _db = await Connection.open();
    return _db.rawQuery('SELECT * FROM student').then((value) {
      return value.map((e) => DTOStudent(
        id: e['id'],
        name: e['name'] as String,
        password: e['password'] as String,
        email: e['email'] as String,
        phone: e['phone'] as String,
        cpf: e['cpf'] as String
      )).toList();
    });
  }
}