import 'package:albus/dominio/dto/dto_teacher.dart';
import 'package:albus/dominio/interface/dao_teacher.dart';


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


  Teacher({required this.dto, required this.dao}){
    id = dto.id;
    name = dto.name;
    description = dto.description;
    cpf = dto.cpf;
    email = dto.email;
    phone = dto.phone;
    photo = dto.photo;
  }


}