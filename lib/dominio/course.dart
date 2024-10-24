import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/dominio/interface/i_dao_course.dart';

class Course {
  late dynamic id;
  late String name;
  late int duration;
  late bool isFree;
  late double price;

  late DTOCourse dto;
  late IDAOCourse dao;

  Course({
    required DTOCourse dto,
    required this.dao,
  }) {
    this.id = dto.id;
    this.name = dto.name;
    this.duration = dto.duration;
    this.isFree = dto.isFree;
    this.price = dto.price;

    validateName();
    validateDuration();
    validatePrice();

    void validateName() {
      if (name.isEmpty) throw Exception('O nome não pode estar vazio!');
    }

    void validateDuration() {
      if (duration <= 0) throw Exception('A duração deve ser maior que zero!');
    }

    void validatePrice() {
      if (!isFree && price <=0) throw Exception('O preço deve ser maior que zero para cursos pagos!');
    }

    Future<DTOCourse> save(DTOCourse dtoCourse) async {
      validateName();
      validateDuration();
      validatePrice();
      return await dao.save(dtoCourse);
    }

    Future<void> remove(dynamic id) async {
    await dao.remove(id);
    }

    Future<DTOCourse> update(DTOCourse dtoCourse) async {
      dto = await dao.update(dtoCourse);
      return dtoCourse;
    }

    Future<DTOCourse> read(dynamic id) async {
      dto = await dao.read(id);
      return dto;
    }

    Future<List<DTOCourse>> list() async {
      return await dao.list();
    }
  }
}