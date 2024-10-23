import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:albus/dominio/email.dart' as valid_mail;
import 'package:albus/dominio/password.dart' as valid_pass;
import 'package:albus/dominio/phone.dart' as valid_phone;


class Student {
  late dynamic id;
  late String email;
  late String password;
  late String name;
  late String cpf;
  late String phone;
  
  late DTOStudent dto;

  late IDAOStudent dao;

  Student({required this.dao});

  validate({required DTOStudent dto}) {
    id = dto.id;
    name = dto.name;
    cpf = dto.cpf;
    email = dto.email;
    password = dto.password;
    phone = dto.phone!;
  }

  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    validate(dto: dtoStudent);
    return await dao.save(dtoStudent);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }
  
  Future<DTOStudent> update(DTOStudent dtoStudent) async {
    dto = await dao.update(dtoStudent);
    return dtoStudent;
  }

  Future<DTOStudent> read(DTOStudent dtoStudent) async {
    dto = await dao.read(dtoStudent);
    return dtoStudent;
  }

  Future<List<DTOStudent>> list() async {
    return await dao.list();
  }
}