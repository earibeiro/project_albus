import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/app/database/sqlite/dao_student.dart';

class AStudent {
  final DaoStudent dao = DaoStudent();

  Future<DTOStudent?> login(String email, String password) async {
    List<DTOStudent> students = await dao.list();
    for (DTOStudent student in students) {
      if (student.email == email && student.password == password) {
        return student;
      }
    }
    return null;
  }

  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    return await dao.save(dtoStudent);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }

  Future<DTOStudent> update(DTOStudent dtoStudent) async {
    return await dao.update(dtoStudent);
  }

  Future<DTOStudent> read(dynamic id) async {
    return await dao.read(id);
  }

  Future<List<DTOStudent>> list() async {
    return await dao.list();
  }
}