import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/app/database/supabase/dao_student_supa.dart';
import 'package:albus/app/database/supabase/supabase_connection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

void main() {
  late SupabaseClient client;
  late DAOStudentSupa daoStudentSupa;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        return '.';
      },
    );

    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://wnkawcbqwerdbnztmbqq.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indua2F3Y2Jxd2VyZGJuenRtYnFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2NTEyOTcsImV4cCI6MjA0MzIyNzI5N30.bUDD-ImOLNvQCkBL7Zc3v3LRGossiSh4e5mDdoqsl48',
    );

    await SupabaseConnection.open(); // Inicializa o cliente Supabase
    client = SupabaseConnection.client;
    daoStudentSupa = DAOStudentSupa(client);

    // Configuração de segurança da linha
    await client.rpc('set_config', params: {'key': 'row_security', 'value': 'on'}).execute();
  });

  group('DAOStudentSupa Tests', () {
    test('Create Student', () async {
      final student = DTOStudent(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        cpf: '12345678901',
        password: 'password123',
      );

      try {
        final createdStudent = await daoStudentSupa.create(student);
        expect(createdStudent.name, student.name);
        expect(createdStudent.email, student.email);
      } catch (e) {
        fail('Failed to create student: $e');
      }
    });

    test('Read Student', () async {
      final student = DTOStudent(
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        phone: '0987654321',
        cpf: '10987654321',
        password: 'password321',
      );

      try {
        final createdStudent = await daoStudentSupa.create(student);
        final readStudent = await daoStudentSupa.read(createdStudent.id);
        expect(readStudent.name, student.name);
        expect(readStudent.email, student.email);
      } catch (e) {
        fail('Failed to read student: $e');
      }
    });

    test('Update Student', () async {
      final student = DTOStudent(
        name: 'Alice',
        email: 'alice@example.com',
        phone: '1112223333',
        cpf: '11122233344',
        password: 'alicepassword',
      );

      try {
        final createdStudent = await daoStudentSupa.create(student);
        final updatedStudent = DTOStudent(
          id: createdStudent.id,
          name: 'Alice Updated',
          email: 'alice.updated@example.com',
          phone: '4445556666',
          cpf: '11122233344',
          password: 'newpassword',
        );

        final result = await daoStudentSupa.update(updatedStudent);
        expect(result.name, updatedStudent.name);
        expect(result.email, updatedStudent.email);
      } catch (e) {
        fail('Failed to update student: $e');
      }
    });

    test('Delete Student', () async {
      final student = DTOStudent(
        name: 'Bob',
        email: 'bob@example.com',
        phone: '7778889999',
        cpf: '55566677788',
        password: 'bobpassword',
      );

      try {
        final createdStudent = await daoStudentSupa.create(student);
        await daoStudentSupa.remove(createdStudent.id);

        try {
          await daoStudentSupa.read(createdStudent.id);
          fail('Student should have been deleted');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      } catch (e) {
        fail('Failed to delete student: $e');
      }
    });

    test('List Students', () async {
      try {
        final students = await daoStudentSupa.list();
        expect(students, isA<List<DTOStudent>>());
        expect(students, isNotEmpty);
      } catch (e) {
        fail('Failed to list students: $e');
      }
    });
  });
}