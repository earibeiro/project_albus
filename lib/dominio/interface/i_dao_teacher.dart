import 'package:albus/dominio/dto/dto_teacher.dart';

abstract class IDAOTeacher {
  Future<DTOTeacher> save(DTOTeacher dto);
  Future<void> remove(DTOTeacher dto);
  Future<DTOTeacher> update(DTOTeacher dto);
  Future<DTOTeacher> read(DTOTeacher dto);
  Future<List<DTOTeacher>> list();
}