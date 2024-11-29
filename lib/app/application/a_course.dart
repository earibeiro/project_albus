import 'package:albus/app/database/sqlite/dao_course.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/dominio/interface/i_dao_course.dart';

class ACourse {
  final DaoCourse dao = DaoCourse();

  Future<DTOCourse> save(DTOCourse dtoCourse) async {
    return await dao.save(dtoCourse);
  }

  Future<void> remove(dynamic id) async {
    await dao.remove(id);
  }

  Future<DTOCourse> update(DTOCourse dtoCourse) async {
    return await dao.update(dtoCourse);
  }

  Future<DTOCourse> read(dynamic id) async {
    return await dao.read(id);
  }

  Future<List<DTOCourse>> list() async {
    return await dao.list();
  }
}