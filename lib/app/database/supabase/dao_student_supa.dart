import 'package:albus/app/database/supabase/supabase_connection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:albus/dominio/dto/dto_student.dart';
import 'package:albus/dominio/interface/i_dao_student.dart';

class DAOStudentSupa implements IDAOStudent {
  final SupabaseClient _client;

  DAOStudentSupa() : _client = SupabaseConnection.client;

  static DTOStudent fromJson(Map<String, dynamic> json) {
    return DTOStudent(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      cpf: json['cpf'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson(DTOStudent student) {
    return {
      'name': student.name,
      'email': student.email,
      'phone': student.phone,
      'cpf': student.cpf,
      'password': student.password,
    };
  }

  @override
  Future<DTOStudent> create(DTOStudent dtoStudent) async {
    final response = await _client
        .from('student')
        .insert(toJson(dtoStudent))
        .execute();

    if (response.error != null) {
      throw Exception('Failed to create student: ${response.error!.message}');
    }

    return fromJson(response.data[0]);
  }

  @override
  Future<DTOStudent> read(DTOStudent dtoStudent) async {
    final response = await _client
        .from('student')
        .select()
        .eq('id', dtoStudent.id)
        .single()
        .execute();

    if (response.error != null) {
      throw Exception('Failed to read student: ${response.error!.message}');
    }

    return fromJson(response.data);
  }

  @override
  Future<DTOStudent> update(DTOStudent dtoStudent) async {
    final response = await _client
        .from('student')
        .update(toJson(dtoStudent))
        .eq('id', dtoStudent.id)
        .execute();

    if (response.error != null) {
      throw Exception('Failed to update student: ${response.error!.message}');
    }

    return fromJson(response.data[0]);
  }

  @override
  Future<List<DTOStudent>> list() async {
    final response = await _client
        .from('student')
        .select()
        .execute();

    if (response.error != null) {
      throw Exception('Failed to list students: ${response.error!.message}');
    }

    final data = response.data as List<dynamic>;

    return data.map((e) => fromJson(e)).toList();
  }

  @override
  Future<DTOStudent> save(DTOStudent dtoStudent) async {
    final response = await _client
        .from('student')
        .insert(toJson(dtoStudent))
        .execute();

    if (response.error != null) {
      throw Exception('Failed to save student: ${response.error!.message}');
    }

    return fromJson(response.data[0]);
  }

  @override
  Future<void> remove(DTOStudent dtoStudent) async {
    final response = await _client
        .from('student')
        .delete()
        .eq('id', dtoStudent.id)
        .execute();

    if (response.error != null) {
      throw Exception('Failed to remove student: ${response.error!.message}');
    }
  }
}