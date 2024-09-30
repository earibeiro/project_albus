import 'package:flutter_test/flutter_test.dart';
import 'package:albus/app/database/supabase/supabase_connection.dart';
import 'package:supabase/supabase.dart';

void main() {
  late SupabaseClient client;

  // Teste de conexão
  test('Test Supabase connection', () async {
    try {
      await SupabaseConnection.testConnection();
      print('Connection test passed');
    } catch (e) {
      print('Connection test failed: $e');
    }
  });

  setUpAll(() async {
    await SupabaseConnection.open();
    client = SupabaseConnection.client;

    try {
      // Desativar RLS temporariamente
      await client.rpc('set_config', params: {'key': 'row_security', 'value': 'off'}).execute();

      // Verificar se a tabela existe
      var result = await client.from('teacher').select().execute();
      print('Initial select result: ${result.data}');
      if (result.data == null || result.data.isEmpty) {
        // Inserir registros iniciais se a tabela estiver vazia
        print('Inserting initial records...');
        var insertResult = await client.from('teacher').insert([
          {'name': 'Professor A', 'email': 'professorA@example.com'},
          {'name': 'Professor B', 'email': 'professorB@example.com'},
          {'name': 'Professor C', 'email': 'professorC@example.com'},
        ]).execute();
        print('Insert result: ${insertResult.data}');
        if (insertResult.error != null) {
          print('Error inserting initial records: ${insertResult.error!.message}');
        }
      }
    } catch (e) {
      print('Error during setup: $e');
    } finally {
      // Reativar RLS
      await client.rpc('set_config', params: {'key': 'row_security', 'value': 'on'}).execute();
    }
  });

  group('Testes de conexão', () {
    test('teste script create table', () async {
      var list = await client.from('teacher').select().execute();
      print('Select result after table creation: ${list.data}');
      expect(list.data, isNotNull);
      expect(list.data.length, 3);
    });

    test('teste de inserção', () async {
      var insertResult = await client.from('teacher').insert({
        'id': 4,
        'name': 'Professor Teste',
        'email': '',
      }).execute();
      print('Insert result: ${insertResult.data}');
      if (insertResult.error != null) {
        print('Error inserting record: ${insertResult.error!.message}');
      }

      var list = await client.from('teacher').select().execute();
      print('Select result after insertion: ${list.data}');
      expect(list.data, isNotNull);
      expect(list.data.length, 4);
    });

    test('teste de atualização', () async {
      var updateResult = await client.from('teacher').update({
        'name': 'Professor Atualizado',
      }).eq('id', 4).execute();
      print('Update result: ${updateResult.data}');
      if (updateResult.error != null) {
        print('Error updating record: ${updateResult.error!.message}');
      }

      var list = await client.from('teacher').select().execute();
      print('Select result after update: ${list.data}');
      expect(list.data, isNotNull);
      expect(list.data.length, 4);
      expect(list.data.firstWhere((teacher) => teacher['id'] == 4)['name'], 'Professor Atualizado');
    });

    test('teste de exclusão', () async {
      var deleteResult = await client.from('teacher').delete().eq('id', 4).execute();
      print('Delete result: ${deleteResult.data}');
      if (deleteResult.error != null) {
        print('Error deleting record: ${deleteResult.error!.message}');
      }

      var list = await client.from('teacher').select().execute();
      print('Select result after deletion: ${list.data}');
      expect(list.data, isNotNull);
      expect(list.data.length, 3);
    });
  });
}