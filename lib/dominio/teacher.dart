import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/cpf.dart' as validator;

class Teacher {
  late dynamic id;
  late String email;
  late String password;
  late String name;
  late String cpf;
  late String phone;
  
  late DTOTeacher dto;

  late IDAOTeacher dao;

  Teacher({required this.dao});

  validate({required DTOTeacher dto}) {
    id = dto.id;
    name = dto.name;
    cpf = dto.cpf;
    email = dto.email;
    password = dto.password;
    phone = dto.phone!;
  }

  Future<DTOTeacher> save(DTOTeacher dtoTeacher) async {
    validate(dto: dtoTeacher);
    return await dao.save(dtoTeacher);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }
  
  Future<DTOTeacher> update(DTOTeacher dtoTeacher) async {
    dto = await dao.update(dtoTeacher);
    return dtoTeacher;
  }

  Future<DTOTeacher> read(DTOTeacher dtoTeacher) async {
    dto = await dao.read(dtoTeacher);
    return dtoTeacher;
  }

  Future<List<DTOTeacher>> list() async {
    return await dao.list();
  }
}