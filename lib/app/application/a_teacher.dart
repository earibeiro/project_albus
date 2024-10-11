import 'package:albus/app/database/sqlite/dao_teacher.dart';
import 'package:albus/dominio/teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';

class ATeacher {
  late Teacher teacher;
  IDAOTeacher dao = DaoTeacher();

  ATeacher() {
    teacher = Teacher(dao: dao);
    dao =  DaoTeacher();
  }

  Future<DTOTeacher> save(DTOTeacher dtoTeacher) async {
    return await teacher.save(dtoTeacher);
  }

  void remove(dynamic id) async {
    await teacher.remove(id);
  }

  Future <DTOTeacher> update(DTOTeacher dtoTeacher) async {
    return await teacher.update(dtoTeacher);
  }

  Future <DTOTeacher> read(DTOTeacher dtoTeacher) async {
    return await teacher.read(dtoTeacher);
  }

  Future <List<DTOTeacher>> list() async {
    return await teacher.list();
  }
}