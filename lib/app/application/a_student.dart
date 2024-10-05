import 'package:albus/app/database/sqlite/dao_student.dart';
import 'package:albus/dominio/student.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';

class AStudent {
  late Student student;
  IDAOStudent dao = DaoStudent();

  AStudent() {
    student = Student(dao: dao);
    dao = DaoStudent();
  }

  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    return await student.save(dtoStudent);
  }

  /*void remove(dynamic id) async {
    await student.remove(id);
  }*/

}