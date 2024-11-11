import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/app/database/sqlite/dao_teacher.dart';

class ATeacher {
  final DaoTeacher dao = DaoTeacher();

  Future<DTOTeacher?> login(String email, String password) async {
    List<DTOTeacher> teachers = await dao.list();
    for (DTOTeacher teacher in teachers) {
      if (teacher.email == email && teacher.password == password) {
        return teacher;
      }
    }
    return null;
  }

  Future<DTOTeacher> save(DTOTeacher dtoTeacher) async {
    return await dao.save(dtoTeacher);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }

  Future<DTOTeacher> update(DTOTeacher dtoTeacher) async {
    return await dao.update(dtoTeacher);
  }

  Future<DTOTeacher> read(dynamic id) async {
    return await dao.read(id);
  }

  Future<List<DTOTeacher>> list() async {
    return await dao.list();
  }
}