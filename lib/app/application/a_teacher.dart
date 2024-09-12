import 'package:albus/app/database/sqlite/dao_teacher.dart';
import 'package:albus/dominio/teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';

class ATeacher {
  late Teacher teacher;
  IDAOTeacher dao = DaoTeacher();

  ATeacher({required DTOTeacher dto}) {
    teacher = Teacher(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      cpf: dto.cpf,
      email: dto.email,
      phone: dto.phone,
      photo: dto.photo,
      dao: dao,
    );
  }

  Future<void> save() async {
    await teacher.add();
  }
}