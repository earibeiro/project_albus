import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:albus/dominio/name.dart';
import 'package:albus/dominio/email.dart';
import 'package:albus/dominio/phone.dart';
import 'package:albus/dominio/cpf.dart';
import 'package:albus/dominio/password.dart';

class Student {
  late dynamic id;
  late String name;
  late String email;
  late String phone;
  late String cpf;
  late String password;

  late DTOStudent dto;
  late IDAOStudent dao;

  Student({
    required this.dao,
  });

  void validateName(DTOStudent dto) {
    Name(dto.name);
  }

  void validateEmail(DTOStudent dto) {
    Email(dto.email);
  }

  void validatePhone(DTOStudent dto) {
    if (dto.phone == null) {
      throw ArgumentError('Phone cannot be null');
    }
    Phone(dto.phone!);
  }

  void validateCPF(DTOStudent dto) {
    CPF(dto.cpf);
  }

  void validatePassword(DTOStudent dto) {
    Password(dto.password);
  }

  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    validateName(dtoStudent);
    validateEmail(dtoStudent);
    validatePhone(dtoStudent);
    validateCPF(dtoStudent);
    validatePassword(dtoStudent);
    return await dao.save(dtoStudent);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }

  Future<DTOStudent> update(DTOStudent dtoStudent) async {
    validateName(dtoStudent);
    validateEmail(dtoStudent);
    validatePhone(dtoStudent);
    validateCPF(dtoStudent);
    validatePassword(dtoStudent);
    return await dao.update(dtoStudent);
  }

  Future<DTOStudent> read(dynamic id) async {
    return await dao.read(id);
  }

  Future<List<DTOStudent>> list() async {
    return await dao.list();
  }
}