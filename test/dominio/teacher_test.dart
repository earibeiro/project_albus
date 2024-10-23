import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/interface/i_dao_teacher.dart';
import 'package:albus/dominio/teacher.dart';
import 'package:albus/dominio/dto/dto_teacher.dart';

class DAOTeacher implements IDAOTeacher {
  @override
  Future<DTOTeacher> save(DTOTeacher dto) async {
    return dto;
  }

  @override
  Future<void> remove(dynamic id) async {

  }

  @override
  Future<DTOTeacher> update(DTOTeacher dto) async {
    return dto;
  }

  @override
  Future<DTOTeacher> read(dynamic id) async {
    return DTOTeacher(
      id: id,
      name: 'João das Neves',
      email: 'joaodn@example.com',
      phone: '994548786',
      cpf: '881.455.540-04',
      password: 'password123',
    );
  }

  @override
  Future<List<DTOTeacher>> list() async {
    return [
      DTOTeacher(
        id: 1,
        name: 'João das Neves',
        email: 'joaodn@example.com',
        phone: '994548786',
        cpf: '881.455.540-04',
        password: 'password123',
      ),
    ];
  }
}

void main() {
  var dto = DTOTeacher(
    id: 1,
    name: 'João das Neves',
    cpf: '881.455.540-04',
    email: 'joaodn@example.com',
    phone: '994548786',
    password: 'password123',
  );

  var dtoNameEmpty = DTOTeacher(
    id: 2,
    name: '',
    cpf: '881.455.540-04',
    email: 'joaodn@example.com',
    phone: '1234567890',
    password: 'password123',
  );

  var dao = DAOTeacher();
  var teacher = Teacher(dto: dto, dao: dao);

  group('Entidade Teacher', () {
    group('Teste para validação do nome', () {
      test('Entidade Teacher - teste com nome preenchido', () {
        expect(() => teacher.validateName(), returnsNormally);
      });

      test('Entidade Teacher - teste com o nome vazio', () {
        expect(() => Teacher(dto: dtoNameEmpty, dao: dao).validateName(), throwsException);
      });
    });

    group('Teste para validação de email', () {
      test('Entidade Teacher - teste com email preenchido', () {
        expect(() => teacher.validateEmail(), returnsNormally);
      });

      test('Entidade Teacher - teste com email vazio', () {
        var dtoEmailEmpty = DTOTeacher(
          id: 3,
          name: 'João das Neves',
          cpf: '881.455.540-04',
          email: '',
          phone: '1234567890',
          password: 'password123',
        );
        expect(() => Teacher(dto: dtoEmailEmpty, dao: dao).validateEmail(), throwsException);
      });
    });

    group('Teste para validação do CPF', () {
      test('Entidade Teacher - teste com CPF válido', () {
        expect(() => teacher, returnsNormally);
      });

      test('Entidade Teacher - teste com CPF inválido', () {
        var dtoInvalidCpf = DTOTeacher(
          id: 4,
          name: 'João das Neves',
          cpf: '123.456.789-00',
          email: 'joaodn@example.com',
          phone: '1234567890',
          password: 'password123',
        );
        expect(() => Teacher(dto: dtoInvalidCpf, dao: dao), throwsException);
      });
    });

    group('Teste para operações no banco de dados', () {
      test('Entidade Teacher - teste de operação de salvar', () async {
        expect(() => teacher.save(dto), returnsNormally);
      });

      test('Entidade Teacher - teste de operação de remover', () async {
        expect(() => teacher.remove(dto.id), returnsNormally);
      });
    });
  });
}