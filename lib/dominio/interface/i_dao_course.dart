import 'package:albus/dominio/dto/dto_course.dart';

abstract class IDAOCourse {
  Future<DTOCourse> save(DTOCourse dto);
  Future<void> remove(dynamic id);
  Future<DTOCourse> update(DTOCourse dto);
  Future<DTOCourse> read(dynamic id);
  Future<List<DTOCourse>> list();
}