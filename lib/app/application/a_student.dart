import 'package:albus/app/database/sqlite/dao_student.dart';
import 'package:albus/dominio/student.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';

class AStudent {
  late Student student;
  IDAOStudent dao = DaoStudent();

  AStudent({required DTOStudent dto}) {
    student = Student(dto: dto, dao: dao);
  }

  Future<void> save() async {
    await student.add();
  }
}