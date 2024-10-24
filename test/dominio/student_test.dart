import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';
import 'package:albus/dominio/student.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/app/database/sqlite/dao_student.dart';
import 'package:albus/app/database/sqlite/connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Configura o sqflite_common_ffi para testes
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUpAll(() async {
    // Configura o banco de dados para os testes
    await Connection.open();
    await Connection.db.execute('''
      CREATE TABLE IF NOT EXISTS student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        cpf TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  });

  tearDownAll(() async {
    // Limpa o banco de dados após os testes
    await Connection.db.execute('DROP TABLE IF EXISTS student');
    await Connection.close();
  });

  var dto = DTOStudent(
    id: 1,
    name: 'João das Neves',
    email: 'joaodn@example.com',
    phone: '994548786',
    cpf: '881.455.540-04',
    password: 'password123',
  );

  var dtoNameEmpty = DTOStudent(
    id: 2,
    name: '',
    email: 'joaodn@example.com',
    phone: '994548786',
    cpf: '881.455.540-04',
    password: 'password123',
  );

  var dtoEmailInvalid = DTOStudent(
    id: 3,
    name: 'João das Neves',
    email: 'invalid-email',
    phone: '994548786',
    cpf: '881.455.540-04',
    password: 'password123',
  );

  var dtoPhoneInvalid = DTOStudent(
    id: 4,
    name: 'João das Neves',
    email: 'joaodn@example.com',
    phone: 'invalid-phone',
    cpf: '881.455.540-04',
    password: 'password123',
  );

  var dtoCPFInvalid = DTOStudent(
    id: 5,
    name: 'João das Neves',
    email: 'joaodn@example.com',
    phone: '994548786',
    cpf: 'invalid-cpf',
    password: 'password123',
  );

  var dtoPasswordInvalid = DTOStudent(
    id: 6,
    name: 'João das Neves',
    email: 'joaodn@example.com',
    phone: '994548786',
    cpf: '881.455.540-04',
    password: 'short',
  );

  var dao = DaoStudent();
  var student = Student(dao: dao);

  group('Entidade Student', () {
    group('Teste para validação do nome', () {
      test('Entidade Student - teste com nome preenchido', () {
        expect(() => student.validateName(dto), returnsNormally);
      });

      test('Entidade Student - teste com o nome vazio', () {
        expect(() => student.validateName(dtoNameEmpty), throwsArgumentError);
      });
    });

    group('Teste para validação do email', () {
      test('Entidade Student - teste com email válido', () {
        expect(() => student.validateEmail(dto), returnsNormally);
      });

      test('Entidade Student - teste com email inválido', () {
        expect(() => student.validateEmail(dtoEmailInvalid), throwsArgumentError);
      });
    });

    group('Teste para validação do telefone', () {
      test('Entidade Student - teste com telefone válido', () {
        expect(() => student.validatePhone(dto), returnsNormally);
      });

      test('Entidade Student - teste com telefone inválido', () {
        expect(() => student.validatePhone(dtoPhoneInvalid), throwsArgumentError);
      });
    });

    group('Teste para validação do CPF', () {
      test('Entidade Student - teste com CPF válido', () {
        expect(() => student.validateCPF(dto), returnsNormally);
      });

      test('Entidade Student - teste com CPF inválido', () {
        expect(() => student.validateCPF(dtoCPFInvalid), throwsArgumentError);
      });
    });

    group('Teste para validação da senha', () {
      test('Entidade Student - teste com senha válida', () {
        expect(() => student.validatePassword(dto), returnsNormally);
      });

      test('Entidade Student - teste com senha inválida', () {
        expect(() => student.validatePassword(dtoPasswordInvalid), throwsArgumentError);
      });
    });

    group('Teste para operações no banco de dados', () {
      test('Entidade Student - teste de operação de salvar', () async {
        expect(() => student.save(dto), returnsNormally);
      });

      test('Entidade Student - teste de operação de remover', () async {
        expect(() => student.remove(dto.id), returnsNormally);
      });

      test('Entidade Student - teste de operação de atualizar', () async {
        var updatedDto = DTOStudent(
          id: 1,
          name: 'João das Neves Atualizado',
          email: 'joaodn@example.com',
          phone: '994548786',
          cpf: '881.455.540-04',
          password: 'password123',
        );
        expect(() => student.update(updatedDto), returnsNormally);
      });

      test('Entidade Student - teste de operação de ler', () async {
        expect(() => student.read(dto.id), returnsNormally);
      });

      test('Entidade Student - teste de operação de listar', () async {
        expect(() => student.list(), returnsNormally);
      });
    });
  });
}