import 'package:albus/dominio/dto/dto_teacher.dart';

abstract class IDAOTeacher {
  Future<DTOTeacher> save(DTOTeacher dto);
  Future<void> remove(DTOTeacher dto);
}