import 'package:albus/app/database/sqlite/dao_teacher.dart';
import 'package:albus/dominio/teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';

class ATeacher {
  late Teacher teacher;
  IDAOTeacher dao = DaoTeacher();

  ATeacher({required DTOTeacher dto}) {
    teacher = Teacher(dto: dto, dao: dao);
  }

  Future<void> save() async {
    await teacher.add();
  }

  Future<void> remove() async {
    await teacher.remove();
  }

}