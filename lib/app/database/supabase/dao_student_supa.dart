import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:albus/dominio/dto/dto_student.dart';

class DAOStudentSupa {
  final SupabaseClient _client;

  DAOStudentSupa(this._client);

  Map<String, dynamic> toJson(DTOStudent student) {
    return {
      'name': student.name,
      'email': student.email,
      'phone': student.phone,
      'cpf': student.cpf,
      'password': student.password,
    };
  }

  Future<DTOStudent> create(DTOStudent dtoStudent) async {
    final json = toJson(dtoStudent);
    print('Creating student with data: $json');

    final response = await _client
        .from('student')
        .insert(json)
        .execute();

    if (response.error != null) {
      print('Error response: ${response.error!.message}');
      throw Exception('Failed to create student: ${response.error!.message}');
    }

    print('Response data: ${response.data}');
    return fromJson(response.data[0]);
  }

  Future<DTOStudent> read(String id) async {
    final response = await _client
        .from('student')
        .select()
        .eq('id', id)
        .single()
        .execute();

    if (response.error != null) {
      throw Exception('Failed to read student: ${response.error!.message}');
    }

    return fromJson(response.data);
  }

  Future<DTOStudent> update(DTOStudent dtoStudent) async {
    final json = toJson(dtoStudent);
    final response = await _client
        .from('student')
        .update(json)
        .eq('id', dtoStudent.id)
        .execute();

    if (response.error != null) {
      throw Exception('Failed to update student: ${response.error!.message}');
    }

    return fromJson(response.data[0]);
  }

  Future<void> remove(String id) async {
    final response = await _client
        .from('student')
        .delete()
        .eq('id', id)
        .execute();

    if (response.error != null) {
      throw Exception('Failed to delete student: ${response.error!.message}');
    }
  }

  Future<List<DTOStudent>> list() async {
    final response = await _client
        .from('student')
        .select()
        .execute();

    if (response.error != null) {
      throw Exception('Failed to list students: ${response.error!.message}');
    }

    return (response.data as List).map((json) => fromJson(json)).toList();
  }

  DTOStudent fromJson(Map<String, dynamic> json) {
    return DTOStudent(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      cpf: json['cpf'],
      password: json['password'],
    );
  }
}