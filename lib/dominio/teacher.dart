import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/cpf.dart' as validator;

class Teacher {
  late dynamic id;
  late String name;
  late String? description;
  late String email;
  late String? phone;
  late String cpf;
  late String? photo;

  late DTOTeacher dto;
  late IDAOTeacher dao;

  Teacher({required this.dto, required this.dao}) {
    id = dto.id;
    name = dto.name;
    description = dto.description;
    cpf = dto.cpf;
    email = dto.email;
    phone = dto.phone;
    photo = dto.photo;
    dto = DTOTeacher(id: id, name: name, description: description, cpf: cpf, email: email, phone: phone, photo: photo);

    validator.CPF(cpf);
    _validateName();
    _validateEmail();
  }

  void _validateName() {
    if (name.isEmpty) throw Exception('Name cannot be empty!');
  }

  void _validateEmail() {
    if (email.isEmpty) throw Exception('Email cannot be empty!');

  }

  Future<DTOTeacher> add() async {
    return await dao.save(dto);
  }

  bool delete(DTOTeacher dto) {
    dao.remove(dto);
    return true;
  }
}