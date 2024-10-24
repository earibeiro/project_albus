import 'package:albus/app/database/sqlite/dao_course.dart';
import 'package:albus/dominio/course.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/dominio/interface/i_dao_course.dart';

class ACourse {
  late Course course;
  IDAOCourse dao = DaoCourse();

  ACourse() {
    course = Course(dto: DTOCourse(name: '', duration: 0, isFree: false, price: 0.0), dao: dao);
    dao = DaoCourse();
  }

  Future<DTOCourse> save(DTOCourse dtoCourse) async {
    return await course.save(dtoCourse);
  }

  void remove(dynamic id) async {
    await course.remove(id);
  }

  Future<DTOCourse> update(DTOCourse dtoCourse) async {
    return await course.update(dtoCourse);
  }

  Future<DTOCourse> read(dynamic id) async {
    return await course.read(id);
  }

  Future<List<DTOCourse>> list() async {
    return await course.list();
  }
}