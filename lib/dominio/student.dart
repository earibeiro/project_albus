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

  Student({required this.dao}) {
    id = dto.id;
    name = dto.name;
    valid_mail.Email(email);
    valid_pass.Password(password);
    valid_phone.Phone(phone);
  }

  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    dto = await dao.save(dto);
    return dtoStudent;
  }

  /*Future<void> remove() async {
    await dao.remove(dto);
  }*/
  

}