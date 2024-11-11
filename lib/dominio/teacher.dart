import 'package:albus/dominio/cpf.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/name.dart';
import 'package:albus/dominio/password.dart';
import 'package:albus/dominio/email.dart';

class Teacher {
  late dynamic id;
  late String name;
  late String email;
  late String phone;
  late String cpf;
  late String password;

  late DTOTeacher dto;
  late IDAOTeacher dao;

  Teacher({
    required this.dao,
  });

  void validateName(DTOTeacher dto) {
    Name(dto.name);
  }

  void validateEmail(DTOTeacher dto) {
    Email(dto.email);
  }

  void validatePhone(DTOTeacher dto) {
    if (dto.phone == null) {
      throw ArgumentError('Phone cannot be null');
    }
  }

  void validateCpf(DTOTeacher dto) {
    CPF(dto.cpf);
  }

  void validatePassword(DTOTeacher dto) {
    Password(dto.password);
  }

  Future<DTOTeacher> save(DTOTeacher dtoTeacher) async {
    validateName(dtoTeacher);
    validateEmail(dtoTeacher);
    validatePhone(dtoTeacher);
    validateCpf(dtoTeacher);
    validatePassword(dtoTeacher);
    return await dao.save(dtoTeacher);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }

  Future<DTOTeacher> update(DTOTeacher dtoTeacher) async {
    validateName(dtoTeacher);
    validateEmail(dtoTeacher);
    validatePhone(dtoTeacher);
    validateCpf(dtoTeacher);
    validatePassword(dtoTeacher);
    return await dao.update(dtoTeacher);
  }

  Future<DTOTeacher> read(dynamic id) async {
    return await dao.read(id);
  }

  Future<List<DTOTeacher>> list() async {
    return await dao.list();
  }
}