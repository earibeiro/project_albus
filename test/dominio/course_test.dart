import 'package:flutter_test/flutter_test.dart';
import 'package:albus/dominio/interface/i_dao_course.dart';
import 'package:albus/dominio/course.dart';
import 'package:albus/dominio/dto/dto_course.dart';
import 'package:albus/app/database/sqlite/dao_course.dart';
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
      CREATE TABLE IF NOT EXISTS course (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        duration INTEGER NOT NULL,
        isFree INTEGER NOT NULL,
        price REAL NOT NULL
      )
    ''');
  });

  tearDownAll(() async {
    // Limpa o banco de dados após os testes
    await Connection.db.execute('DROP TABLE IF EXISTS course');
    await Connection.close();
  });

  var dto = DTOCourse(
    id: 1,
    name: 'Curso de Flutter',
    duration: 40,
    isFree: false,
    price: 200.0,
  );

  var dtoNameEmpty = DTOCourse(
    id: 2,
    name: '',
    duration: 40,
    isFree: false,
    price: 200.0,
  );

  var dtoDurationInvalid = DTOCourse(
    id: 3,
    name: 'Curso de Flutter',
    duration: 0,
    isFree: false,
    price: 200.0,
  );

  var dtoPriceInvalid = DTOCourse(
    id: 4,
    name: 'Curso de Flutter',
    duration: 40,
    isFree: false,
    price: 0.0,
  );

  var dao = DaoCourse();
  var course = Course(dto: dto, dao: dao);

  group('Entidade Course', () {
    group('Teste para validação do nome', () {
      test('Entidade Course - teste com nome preenchido', () {
        expect(() => course.validateName(), returnsNormally);
      });

      test('Entidade Course - teste com o nome vazio', () {
        expect(() => Course(dto: dtoNameEmpty, dao: dao).validateName(), throwsException);
      });
    });

    group('Teste para validação da duração', () {
      test('Entidade Course - teste com duração válida', () {
        expect(() => course.validateDuration(), returnsNormally);
      });

      test('Entidade Course - teste com duração inválida', () {
        expect(() => Course(dto: dtoDurationInvalid, dao: dao).validateDuration(), throwsException);
      });
    });

    group('Teste para validação do preço', () {
      test('Entidade Course - teste com preço válido', () {
        expect(() => course.validatePrice(), returnsNormally);
      });

      test('Entidade Course - teste com preço inválido', () {
        expect(() => Course(dto: dtoPriceInvalid, dao: dao).validatePrice(), throwsException);
      });
    });

    group('Teste para operações no banco de dados', () {
      test('Entidade Course - teste de operação de salvar', () async {
        expect(() => course.save(dto), returnsNormally);
      });

      test('Entidade Course - teste de operação de remover', () async {
        expect(() => course.remove(dto.id), returnsNormally);
      });

      test('Entidade Course - teste de operação de atualizar', () async {
        var updatedDto = DTOCourse(
          id: 1,
          name: 'Curso de Flutter Avançado',
          duration: 60,
          isFree: false,
          price: 300.0,
        );
        expect(() => course.update(updatedDto), returnsNormally);
      });

      test('Entidade Course - teste de operação de ler', () async {
        expect(() => course.read(dto.id), returnsNormally);
      });

      test('Entidade Course - teste de operação de listar', () async {
        expect(() => course.list(), returnsNormally);
      });
    });
  });
}