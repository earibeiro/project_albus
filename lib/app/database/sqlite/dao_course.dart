import 'package:albus/dominio/interface/i_dao_course.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:sqflite/sqflite.dart';
import 'package:albus/app/database/sqlite/connection.dart';

class DaoCourse implements IDAOCourse {
  late Database _db;

  @override
  Future<DTOCourse> save(DTOCourse dto) async {
    _db = await Connection.open();
    int id = await _db.rawInsert(
      '''INSERT INTO course(name, duration, isFree, price)
      VALUES (?, ?, ?, ?)''', [dto.name, dto.duration, dto.isFree ? 1 : 0, dto.price]);
    dto.id = id;
    return dto;
  }

  @override
  Future<void> remove(dynamic id) async {
    final db = await Connection.open();
    await db.delete('course', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<DTOCourse> update(DTOCourse dto) async {
    final db = await Connection.open();
    await db.update(
      'course',
      {
        'name': dto.name,
        'duration': dto.duration,
        'isFree': dto.isFree ? 1 : 0,
        'price': dto.price,
      },
      where: 'id = ?',
      whereArgs: [dto.id],
    );
    return dto;
  }

  @override
  Future<DTOCourse> read(dynamic id) async {
    final db = await Connection.open();
    List<Map<String, dynamic>> result = await db.query('course', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return DTOCourse(
        id: result.first['id'],
        name: result.first['name'],
        duration: result.first['duration'],
        isFree: result.first['isFree'] == 1,
        price: result.first['price'],
      );
    } else {
      throw Exception('Curso não encontrado');
    }
  }

  @override
  Future<List<DTOCourse>> list() async {
    final db = await Connection.open();
    List<Map<String, dynamic>> result = await db.query('course');
    return result.map((data) => DTOCourse(
      id: data['id'],
      name: data['name'],
      duration: data['duration'],
      isFree: data['isFree'] == 1,
      price: data['price'],
    )).toList();
  }
}