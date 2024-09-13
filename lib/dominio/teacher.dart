import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/cpf.dart' as validator;

class Teacher {
  late dynamic id;
  late String name;
  late String? description;
  late String cpf;
  late String email;
  late String? phone;
  late String? photo;

  late DTOTeacher dto;
  late IDAOTeacher dao;

  Teacher({
    required DTOTeacher dto,
    required this.dao,
  }) {
    this.id = dto.id;
    this.name = dto.name;
    this.description = dto.description;
    this.cpf = dto.cpf;
    this.email = dto.email;
    this.phone = dto.phone;
    this.photo = dto.photo;

    validator.CPF(cpf);
    validateName();
    validateEmail();
    this.dto = dto; // Inicializando o campo dto corretamente
  }

  void validateName() {
    if (name.isEmpty) throw Exception('Name cannot be empty!');
  }

  void validateEmail() {
    if (email.isEmpty) throw Exception('Email cannot be empty!');
    // Add more email validation logic if needed
  }

  Future<DTOTeacher> add() async {
    return await dao.save(dto);
  }

  Future<void> remove() async {
    await dao.remove(dto);
  }
}