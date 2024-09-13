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
  Future<void> remove(DTOTeacher dto) async {

  }
}

void main() {
  var dto = DTOTeacher(
    id: 1,
    name: 'João das Neves',
    description: 'Professor de matemática',
    cpf: '881.455.540-04',
    email: 'joaodn@example.com',
    phone: '994548786',
    photo: 'photo_url',
  );

  var dtoNameEmpty = DTOTeacher(
    id: 2,
    name: '',
    description: 'Professor de matemática',
    cpf: '881.455.540-04',
    email: 'joaodn@example.com',
    phone: '1234567890',
    photo: 'photo_url',
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
          description: 'Professor de matemática',
          cpf: '881.455.540-04',
          email: '',
          phone: '1234567890',
          photo: 'photo_url',
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
          description: 'Professor de matemática',
          cpf: '123.456.789-00',
          email: 'joaodn@example.com',
          phone: '1234567890',
          photo: 'photo_url',
        );
        expect(() => Teacher(dto: dtoInvalidCpf, dao: dao), throwsException);
      });
    });

    group('Teste para operações no banco de dados', () {
      test('Entidade Teacher - teste de operação de salvar', () async {
        expect(() => teacher.add(), returnsNormally);
      });

      test('Entidade Teacher - teste de operação de remover', () async {
        expect(() => teacher.remove(), returnsNormally);
      });
    });
  });
}